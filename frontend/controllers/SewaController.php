<?php
namespace frontend\controllers;
use Yii;
use common\models\Sewa;
use common\models\VwSewa;
use common\models\VwSewaPic;
use yii\rest\ActiveController;
use yii\base\ErrorException;
use yii\base\Model;
use common\models\LoginForm;
use frontend\models\SignupForm;

class SewaController extends ActiveController
{
    public $modelClass = 'common\models\Sewa';
    public function actions()
    {
      $actions = parent::actions();
      return $actions;
    }
      protected function verbs()
        {
        return [
           'get' => ['GET'],
           'qc-pic' => ['GET'],
           'view' => ['GET'],
        ];
      }
     
      public function actionGet(){
        \Yii::$app->response->format = \yii\web\Response:: FORMAT_JSON;
        $sewa = VwSewa::find()->all();
        if(count($sewa) > 0 ){
          return $sewa;
        }else{
          return $sewa;
        }
      }
      public function actionQcPic($id){
        \Yii::$app->response->format = \yii\web\Response:: FORMAT_JSON;
        $sewa = VwSewaPic::find()->where(['nama_pic'=> $id])->andWhere(['tot_result'=>0])->all();
        if(count($sewa) > 0 ){
          return $sewa;
        }else{
          return $sewa;
        }
      }
      public function actionView($id){
        \Yii::$app->response->format = \yii\web\Response:: FORMAT_JSON;
        $sewa = VwSewa::find()->where(['no_sewa'=> $id])->all();
        if(count($sewa) > 0 ){
          return array('status' => true, 'data'=> $sewa);
        }else{
          return array('status'=>false,'data'=> 'No Data Found');
        }
      }
      
}
