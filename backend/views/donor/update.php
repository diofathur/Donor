<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Donor */

$this->title = 'Update Donor: ' . $model->id_donor;
$this->params['breadcrumbs'][] = ['label' => 'Donors', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id_donor, 'url' => ['view', 'id' => $model->id_donor]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="donor-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
