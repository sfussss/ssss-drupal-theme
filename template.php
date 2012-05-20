<?php

function ssss_links__system_main_menu($variables) {
	$html = "<ul class=\"nav\">\n";
	foreach ($variables['links'] as $link) {
		$html .= "<li>".l($link['title'], $link['href'], $link)."</li>";
	}
	$html .= "</ul>\n";

	return $html;
}

function ssss_links__system_secondary_menu($variables) {
	$html = "<ul class=\"nav\">\n";
	foreach ($variables['links'] as $link) {
		$html .= "<li>".l($link['title'], $link['href'], $link)."</li>";
	}
	$html .= "</ul>\n";

	return $html;
}
