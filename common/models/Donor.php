<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "donor".
 *
 * @property int $id_donor
 * @property int $no_antrian
 * @property int|null $id_user
 * @property string|null $nama
 * @property int|null $usia
 * @property string|null $jk
 * @property int|null $tinggi_badan
 * @property int|null $berat_badan
 * @property string|null $golongan_darah
 * @property string|null $tanggal
 * @property string|null $status
 *
 * @property User $user
 * @property History[] $histories
 */
class Donor extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'donor';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['no_antrian'], 'required'],
            [['no_antrian', 'id_user', 'usia', 'tinggi_badan', 'berat_badan'], 'integer'],
            [['jk'], 'string'],
            [['tanggal'], 'safe'],
            [['nama'], 'string', 'max' => 255],
            [['golongan_darah'], 'string', 'max' => 4],
            [['status'], 'string', 'max' => 32],
            [['id_user'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['id_user' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_donor' => 'Id Donor',
            'no_antrian' => 'No Antrian',
            'id_user' => 'Id User',
            'nama' => 'Nama',
            'usia' => 'Usia',
            'jk' => 'Jk',
            'tinggi_badan' => 'Tinggi Badan',
            'berat_badan' => 'Berat Badan',
            'golongan_darah' => 'Golongan Darah',
            'tanggal' => 'Tanggal',
            'status' => 'Status',
        ];
    }

    /**
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'id_user']);
    }

    /**
     * Gets query for [[Histories]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getHistories()
    {
        return $this->hasMany(History::className(), ['id_donor' => 'id_donor']);
    }
}
