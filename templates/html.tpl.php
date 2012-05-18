<?php
include_once './includes/bootstrap.inc';
drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);
drupal_flush_all_caches();
?>

<!doctype html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><?php print $head_title; ?></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">

		<?php print $head; ?>
		<?php print $styles; ?>

		<script type="text/javascript" data-main="<?php print url().path_to_theme().'/bin/js/coffee_build/script.js' ?>" src="<?php print url().path_to_theme().'/bin/js/static/lib/require.js'; ?>"></script>
	</head>

	<body>

			<?php print $page_top; ?>
			<?php print $page; ?>
			<?php print $page_bottom; ?>

		<?php print $scripts; ?>
	</body>
</html>
