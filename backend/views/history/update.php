<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\History */

$this->title = 'Update History: ' . $model->id_history;
$this->params['breadcrumbs'][] = ['label' => 'Histories', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id_history, 'url' => ['view', 'id' => $model->id_history]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="history-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
