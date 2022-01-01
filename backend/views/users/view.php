<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Users */

$this->title = $model->username;
$this->params['breadcrumbs'][] = ['label' => 'Users', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="users-view">

    <h1>User : <?= Html::encode($this->title) ?></h1>


    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'username',
            // 'auth_key',
            // 'password_hash',
            // 'password_reset_token',
            'email:email',
            // 'status',
            // 'created_at',
            // 'updated_at',
            // 'verification_token',
            // 'level',
        ],
    ]) ?>
    
    <h1>History Donor:</h1>
    <table class="table">
      <tr>
          <td>No Antrian</td>
          <td>Nama</td>
          <td>Golongan Darah</td>
          <td>Tanggal Donor</td>
          <td>Status</td>
      </tr>
    <?php foreach($donor as $key){ ?>
          <tr>
            <td><?= $key->no_antrian ?></td>
            <td><?= $key->nama ?></td>
            <td><?= $key->golongan_darah ?></td>
            <td><?= $key->tanggal ?></td>
            <td><?= $key->status ?></td>
        </tr>
    <?php }?>
    </table>
</div>
