<?php /* The navbar. */ ?>
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <a class="brand" href="#">SSSS</a>
      <div class="nav-collapse">
        <?php if ($main_menu): ?>
          <?php print theme('links__system_main_menu', array('links' => $main_menu, 'attributes' => array('id' => 'main-menu', 'class' => array('links', 'clearfix')), 'heading' => array('text' => t('Main menu'), 'level' => 'h2', 'class' => array('element-invisible'))));  ?>
          <?php print theme('links__system_secondary_menu', array('links' => $secondary_menu, 'attributes' => array('id' => 'secondary-menu', 'class' => array('links', 'clearfix')), 'heading' => array('text' => t('Secondary menu'), 'level' => 'h2', 'class' => array('element-invisible'))));  ?>
        <?php endif; ?>
      </div>
    </div>
  </div>
</div>

<div class="container">
  
  <header><div>
    <?php print render($page['header']); ?>
  </div></header>

  <?php if ($page['hero_unit']): ?>
    <div class="hero-unit"><?php print render($page['hero_unit']); ?></div>
  <?php endif; ?>

  <?php if ($page['home_page_content']): ?>
    <?php print render($page['home_page_content']); ?>
  <?php endif; ?>

  <div class="row">

    <div class="span4">
      <?php if ($page['highlighted']): ?>
        <div id="highlighted"><?php print render($page['highlighted']); ?></div>
      <?php endif; ?>

      <?php if ($breadcrumb): ?>
        <div id="breadcrumb"><?php print $breadcrumb; ?></div>
      <?php endif; ?>

      <?php print $messages; ?>
      <?php print render($title_prefix); ?>

      <?php if ($title): ?>
        <h1 class="title" id="page-title"><?php print $title; ?></h1>
      <?php endif; ?>

      <?php print render($title_suffix); ?>

      <?php if ($tabs): ?>
        <div class="tabs"><?php print render($tabs); ?></div>
      <?php endif; ?>

      <?php print render($page['help']); ?>

      <?php if ($action_links): ?>
        <ul class="action-links"><?php print render($action_links); ?></ul>
      <?php endif; ?>

      <?php print render($page['content']); ?>
    </div>

    <?php if ($page['home_center_column']): ?>
      <div class="span4">
        <?php print render($page['home_center_column']); ?>
      </div>
    <?php endif; ?>

    <?php if ($page['home_right_column']): ?>
      <div class="span4">
        <?php print render($page['home_right_column']); ?>
      </div>
    <?php endif; ?>

  </div>

  <footer><div class="footer">
    <?php print render($page['footer']); ?>
  </div></footer>

</div>
