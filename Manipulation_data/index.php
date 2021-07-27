<?php

$data = json_decode(file_get_contents('./dataset.json'), true);
$dataMatches = $data['matches'];
$dataChampions = $data['champions'];

//################### Best Range Champions ###################

function getBestRange($dataChampions)
{
    foreach ($dataChampions as $key => $value) {
        $championR = $value['stats']['attackrange'];
        $championRange[$key] = $championR;
    }
    $bestRangeIds = array_keys($championRange, max($championRange));
    foreach ($bestRangeIds as $value) {
        return($dataChampions[$value]);
    }
}

//################### Weakest Champions ###################
function getWeakest($dataChampions)
{
    foreach ($dataChampions as $key => $value) {
        $armor = $value['stats']['armor'];
        $armorperlevel = $value['stats']['armorperlevel'];

        $level = 18;
        $armorlevel = $armorperlevel * $level + $armor;
        $championArmorLevel[$key] = $armorlevel;
    }
    $championsLowestArmor = array_keys($championArmorLevel, min($championArmorLevel));
    foreach ($championsLowestArmor as $value) {
       return($dataChampions[$value]);
    }
}

//################### Last time Caitlyn was played ###################

function getLastChampionMatch($dataChampions, $dataMatches)
{
    foreach ($dataChampions as  $value) {
        if (strtolower($value['name']) == strtolower('Caitlyn')) {
            $championId = $value['key'];
        }
    }
    foreach ($dataMatches as $value) {
        if ($value['champion'] == $championId) {
            $championMatches[$value['gameId']] = $value['timestamp'];
        }
    }
   $lastChampionMatch = array_keys($championMatches, max($championMatches));

    $lastChampionMatchId = implode(' ', $lastChampionMatch);
    return $lastChampionMatchId;
}

//################### The most played Champion ###################
function getMostPlayed($dataChampions, $dataMatches)
{
    foreach ($dataMatches as $value) {
        $championIds[] = $value['champion'];
    }

    $mostPlayedList = array_count_values($championIds);
    $mostPlayedPlayer = array_keys($mostPlayedList, max($mostPlayedList));
    foreach ($mostPlayedPlayer as $playerId) {
        $mostPlayed['id'] = $playerId;
        $mostPlayed['rounds'] = $mostPlayedList[$playerId];
        foreach ($dataChampions as $champion) {
            if ($playerId == $champion['key']) {
                $mostPlayed['name'] = $champion['name'];
            }
        }
        return $mostPlayed;
    }
}




$bestRange = getBestRange($dataChampions);

$weakest = getWeakest($dataChampions);

$lastMatch = getLastChampionMatch($dataChampions, $dataMatches);

$mostPlayed = getMostPlayed($dataChampions, $dataMatches);
?>
<p>The best range : <?= $bestRange['name'];?> </p>

<p>The weakest : <?= $weakest['name'];?> </p>

<p>The last match of "Caitlyn" was the n˚ <?= $lastMatch?></p>

<p>  <?= $mostPlayed['name']?> have been played <?= $mostPlayed['rounds'] ?> times</p>
