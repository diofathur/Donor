<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "history".
 *
 * @property int $id_history
 * @property int|null $id_donor
 * @property string $tanggal_history
 *
 * @property Donor $donor
 */
class History extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'history';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id_donor'], 'integer'],
            [['tanggal_history'], 'safe'],
            [['id_donor'], 'exist', 'skipOnError' => true, 'targetClass' => Donor::className(), 'targetAttribute' => ['id_donor' => 'id_donor']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_history' => 'Id History',
            'id_donor' => 'Id Donor',
            'tanggal_history' => 'Tanggal History',
        ];
    }

    /**
     * Gets query for [[Donor]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getDonor()
    {
        return $this->hasOne(Donor::className(), ['id_donor' => 'id_donor']);
    }
}
