## Assginment 1: Using Mask RCNN

> ✅✅ 가중치 파일은 git에 올리는 것, 메일에 보내는 것 모두 불가하여 google 공유 drive에 따로 올려두었습니다. 링크는 아래와 같습니다.<br> [가중치 파일](https://drive.google.com/drive/folders/1yLv_ZeCCQqsgPy5aG94W3ZVhrK5_Gkp4?usp=sharing)

### #1_Mask_RCNN 다운로드
[Mask_RCNN 공식 github](https://github.com/matterport/Mask_RCNN) 에서 Download Zip 후 압축 풀기 또는 git clone

### #2_Anaconda 가상환경 설정
1. requirements.txt의 모든 패키지 설치 ➡️ `pip install -r requirements.txt` <br><br>
    <img width="500" alt="Untitled (2)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/42495844-b69e-4dc4-900f-3937c553af75">
2. train을 위한 COCO weights 다운로드 ➡️ `python3 setup.py install`
3. train을 위한 balloon dataset 다운로드 ➡️ [Mask_RCNN releases](https://github.com/matterport/Mask_RCNN/releases)
4. Mask_RCNN과 패키지 버전 맞추기
   - Keras와 Tensorflow
     <details>
        <summary>에러 이미지 보기</summary><br>
        <div markdown="1">
          <img width="757" alt="Untitled (3)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/6e89288d-d01e-4fe4-967e-f2d5c144ff2a">
        </div>
        </details>
   - h5py
     <details>
        <summary>에러 이미지 보기</summary><br>
        <div markdown="1">
         <img width="753" alt="Untitled (4)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/8b499659-bfe7-4dc7-b577-d6fbdc1844aa">     
        </div>
        </details>
   - scikit-image
     <details>
        <summary>에러 이미지 보기</summary><br>
        <div markdown="1">
            <img width="669" alt="Untitled (6)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/72d50d69-4dc9-4971-919d-eb93d73b801e">
        </div>
        </details>
     
    Mask RCNN은 일반적으로 다음과 같은 버전에서 잘 작동하므로 재설치한다.
    ```
    pip install keras==2.1.5
    pip install tensorflow==1.15.0
    pip install h5py==2.10.0 --force-reinstall
    pip install scikit-image==0.16.2
    ```
### #3_ train balloon set
Mask RCNN 에서 제공하는 COCO weights와 balloon dataset으로 train 시키기 <br>
[balloon.py](samples/balloon/balloon.py) 코드를 실행하면 train 할 수 있다. <br>
➡️ `python samples/balloon/balloon.py train --dataset=balloon_dataset/balloon --weights=coco`
    
<img width="500" alt="Untitled (8)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/378c7877-b507-4585-bffd-947ea6c688ba"><br><br>
결과로 아래와 같이 mask_rcnn_balloon_0001.h5 가중치 파일이 생긴다. <br><i>노트북 성능이 좋지 않아 1 epoch만 train 시켰습니다. 🥲</i><br><br>
<img width="500" alt="Untitled (9)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/f6e2bc17-6f43-45ac-b365-d7a85c4d9846"><br>
[가중치 파일 다운로드 경로](https://drive.google.com/drive/folders/1yLv_ZeCCQqsgPy5aG94W3ZVhrK5_Gkp4?usp=sharing)

### #4_ test model
3번에서 만든 가중치 파일을 이용하여 [model](samples/balloon/inspect_balloon_model.ipynb) 을 돌릴 수 있다. 주요 결과는 다음과 같다.<br>
<i>model을 돌리기 위해 jupyter notebook을 이용하였다.</i>
- object detection 후 시각화 <br><br>
  <img width="432" alt="object detection" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/672e3b45-cfff-436b-9abe-e1f68de8adf5">
- object detection의 결과로 얻은 마스크를 이용해 이미지에 특정 색깔을 입힌 후 시각화<br><br>
  <img width="433" alt="splash" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/9a54020c-2616-4441-8c92-169f25558f54">
- 이미지 내에서 어떤 객체가 어디에 위치해 있는지 시각화 <br><br>
  <img width="433" alt="Untitled (12)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/6f2203c0-1917-435b-a722-289aad001490">
- RoI를 정제한 후 시각화 <br><br>
  <img width="433" alt="Untitled (13)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/9d272b1e-3c1a-45d6-aeee-2f94dc80de7f">
- 최종적으로 탐지된 각 객체에 대해 원래 RoI와 정제된 RoI 비교하며 시각화. <i>결과적으로 바운딩 박스 중 가장 높은 점수를 가진 바운딩 박스만이 이미지 위에 표시</i> <br><br>
  <img width="433" alt="Untitled (14)" src="https://github.com/jyunimyon/2023_2_opensw_202111477/assets/101866554/926126e4-f489-4c84-9c99-84e625ba9ded">

