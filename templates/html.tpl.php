<!doctype html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><?php echo $head_title; ?></title>

		<?php echo $head; ?>
		<?php echo $styles; ?>
	</head>

	<body>
		<?php echo $page_top; ?>
		<?php echo $page; ?>
		<?php echo $page_bottom; ?>

		<script type="text/javascript" data-main="<?php echo url().path_to_theme().'/bin/js/coffee_build/script.js' ?>" src="<?php echo url().path_to_theme().'/bin/js/ssss/lib/require/require.js'; ?>"></script>
		<?php echo $scripts; ?>
	</body>
</html>
