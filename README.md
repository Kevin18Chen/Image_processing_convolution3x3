# Image_processing_convolution3x3
## 1. 模組說明
模組使用AXI-DMA來傳輸資料，首先資料會經由控制模組將圖片每一排像素分配到各個暫存器，當資料儲存到一定的數量後才會開始做運算，直到所有像素運算完畢。在卷積運算模組中可以調整kernel，來做不同的影像處理，但此模組僅能做整數運算。

![image](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/conv512x512.png)

