<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\Donor */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="donor-form">

    <?php $form = ActiveForm::begin(); ?>

    <!--<?= $form->field($model, 'no_antrian')->textInput() ?>-->

    <!--<?= $form->field($model, 'id_user')->textInput() ?>-->

    <!--<?= $form->field($model, 'nama')->textInput(['maxlength' => true]) ?>-->

    <!--<?= $form->field($model, 'usia')->textInput() ?>-->

    <!--<?= $form->field($model, 'jk')->dropDownList([ 'Laki-laki' => 'Laki-laki', 'Perempuan' => 'Perempuan', ], ['prompt' => '']) ?>-->

    <!--<?= $form->field($model, 'tinggi_badan')->textInput() ?>-->

    <!--<?= $form->field($model, 'berat_badan')->textInput() ?>-->

    <!--<?= $form->field($model, 'golongan_darah')->textInput(['maxlength' => true]) ?>-->

    <!--<?= $form->field($model, 'tanggal')->textInput() ?>-->

    <?= $form->field($model, 'status')->dropDownList([ 'Active' => 'Active', 'Finish' => 'Finish', ], ['prompt' => '']) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
