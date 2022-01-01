<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Donors';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="donor-index">

    <h1><?= Html::encode($this->title) ?></h1>


    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id_donor',
            'no_antrian',
            // 'id_user',
            'nama',
            'usia',
            'jk',
            'tinggi_badan',
            'berat_badan',
            'golongan_darah',
            'tanggal',
            'status',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>


</div>
