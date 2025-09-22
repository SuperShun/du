<?php
function fishBgPlugin() {

    echo <<<html


<link rel="stylesheet" href="/template/fish_bg/fish_bg.css" />

    

<div id="jsi-flying-fish-container" class="fish-container"></div>
<script src="/template/fish_bg/fish_bg.js"></script>

html;


}

addAction('footjs', 'fishBgPlugin');



?>