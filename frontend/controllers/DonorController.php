<?php
namespace frontend\controllers;
use Yii;
use common\models\Donor;
use common\models\History;
use yii\rest\ActiveController;
use yii\base\ErrorException;
use yii\base\Model;
use common\models\LoginForm;
use frontend\models\SignupForm;

class DonorController extends ActiveController
{
    public $modelClass = 'common\models\Donor';
    public function actions()
    {
      $actions = parent::actions();
      return $actions;
    }
      protected function verbs()
        {
        return [
           'get' => ['GET'],
           'status' => ['POST'],
           'reschedule' => ['POST'],
           'view' => ['GET'],
           'post' => ['POST'],
        ];
      }
      public function actionGet($id){
        \Yii::$app->response->format = \yii\web\Response:: FORMAT_JSON;
     
        $Donor = Donor::find()->where(['id_user'=> $id])->all();
          if(count($Donor) > 0 ){
            return array('status' => true, 'data'=> $Donor);
          }else{
            return array('status'=>false,'data'=> 'No Donor Found');
          }
       
      }
      public function actionPost(){
        $model = new Donor();
        $history = new History();
        $params = Yii::$app->request->post();
        $maxno = Donor::find()->where(['tanggal'=> $params['tanggal']])->count();

         $model->id_user = $params['id_user'];
         $model->no_antrian = $maxno+1;
         $model->nama = $params['nama'];
         $model->usia = $params['usia'];
         $model->jk = $params['jk'];
         $model->tinggi_badan = $params['tinggi_badan'];
         $model->berat_badan = $params['berat_badan'];
         $model->golongan_darah = $params['golongan_darah'];
         $model->tanggal = $params['tanggal'];
         $model->status = "Active";

        //  $history->id_donor = $params['']
         if ($model->save()) {
            $history->id_donor = $model['id_donor'];
            $history->status = "Active";
            if ($history->save()) {
                $response['message'] = 'Success Save!';
                $response['status'] = 1;
                return $response;
            } else {
                $model->validate();
                $response['message'] = 'Error! Can\'t Save History.';
                $response['status'] = 0;
                $response['errors'] = $model->getErrors();
                return $response;
            }
         } else {
                $model->validate();
                $response['message'] = 'Error! Can\'t Save.';
                $response['status'] = 0;
                $response['errors'] = $model->getErrors();
                return $response;
         }
       }
       public function actionStatus($id){
        $model = Donor::find()->where(['id_donor'=> $id])->one();
        $history = new History();

        $params = Yii::$app->request->post();
         $model->status = $params['status'];
         if ($model->save()) {
            $history->id_donor = $id;
            $history->status = $params['status'];
            if ($history->save()) {
                $response['message'] = 'Success Save!';
                $response['status'] = 1;
                return $response;
            } else {
                $model->validate();
                $response['message'] = 'Error! Can\'t Save History.';
                $response['status'] = 0;
                $response['errors'] = $model->getErrors();
                return $response;
            }
        } else {
              $model->validate();
              
              $response['message'] = 'Error! Can\'t Save.';
              $response['status'] = 0;
              $response['errors'] = $model->getErrors();
                return $response;
        }
       }
       public function actionReschedule($id){
        $model = new Donor();
        $history = new History();

        $params = Yii::$app->request->post();
        $models = Donor::find()->where(['id_donor'=> $id])->one();
        $maxno = Donor::find()->where(['tanggal'=> $params['tanggal']])->count();
        // $model = new Donor();
         $models->status = "Reschedule";

         $model->id_user = $models['id_user'];
         $model->no_antrian = $maxno+1;
         $model->nama = $models['nama'];
         $model->usia = $models['usia'];
         $model->jk = $models['jk'];
         $model->tinggi_badan = $models['tinggi_badan'];
         $model->berat_badan = $models['berat_badan'];
         $model->golongan_darah = $models['golongan_darah'];
         $model->tanggal = $params['tanggal'];
         $model->status = "Active";
         if ($models->save() && $model->save()) {
            $history->id_donor = $id;
            $history->status = "Active";
            if ($history->save()) {
                $response['message'] = 'Success Save!';
                $response['status'] = 1;
                return $response;
            } else {
                $model->validate();
                $response['message'] = 'Error! Can\'t Save History.';
                $response['status'] = 0;
                $response['errors'] = $model->getErrors();
                return $response;
            }
        } else {
              $model->validate();
              
              $response['message'] = 'Error! Can\'t Save.';
              $response['status'] = 0;
              $response['errors'] = $model->getErrors();
                return $response;
        }
       }
      public function actionView($id){
        \Yii::$app->response->format = \yii\web\Response:: FORMAT_JSON;
        $donor = Donor::find()->where(['id_donor'=> $id])->all();
        if(count($donor) > 0 ){
          return array('status' => true, 'data'=> $donor);
        }else{
          return array('status'=>false,'data'=> 'No EventList Found');
        }
      }
     
}
