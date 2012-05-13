<div>
	<?php echo render($page['header']); ?>
	<?php echo $breadcrumb; ?>
	<?php if ($primary_nav): echo $primary_nav; endif; ?>
	<?php if ($secondary_nav): echo $secondary_nav; endif; ?>
	<?php echo render($page['content']); ?>
	<?php echo render($page['footer']); ?>
</div>
