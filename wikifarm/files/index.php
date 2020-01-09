<?php

$dir = '/etc/apache2/conf-enabled';
$files = scandir($dir);
$wikis = [];
foreach ($files as $file) {
	if (stripos($file, 'wikifarm_') === 0) {
		if (stripos($file, '.conf') !== false) {
			$wiki = substr(substr($file, 9), 0, -5);
			if ($wiki !== "") {
				$wikis[] = $wiki;
			}
		}
	}
}
if ($wikis != []) {
	echo '<div align="center" width="100%"><table><tr>';
	$count = 0;
	foreach ($wikis as $wiki) {
		$logo = "/$wiki/branding/logo.png";
		echo '<td style="text-align:center;width:150px;padding:10px;">';
		echo '<img src="' . $logo . '" style="width:64px;"><br/>';
		echo '<a href = "/' . $wiki . '" target="_blank">' . $wiki . '</a>';
		echo '</td>';
		$count++;
		if ( $count > 4 ) {
			echo '</tr><tr>';
			$count = 0;
		}
	}
	echo '</tr></table></div>';
}
