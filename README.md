# Image_processing_convolution3x3
## 1. 模組說明
模組使用AXI-DMA來傳輸資料，首先資料會經由控制模組將圖片每一排像素分配到各個暫存器，當資料儲存到一定的數量後才會開始做運算，直到所有像素運算完畢。在卷積運算模組中可以調整kernel，來做不同的影像處理，但此模組僅能處理512x512的灰階圖片，並做整數運算。

![!\[image\](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/conv512x512.png)](https://github.com/Kevin18Chen/Image_processing_convolution3x3/blob/main/img/conv512x512.png)

## 2.使用說明
下載檔案後請先製作IP，後參考下圖布置測試架構，其中ILA不需要的話可以移除。

![!\[image\](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/test_architecture.png)](https://github.com/Kevin18Chen/Image_processing_convolution3x3/blob/main/img/test_architecture.png)

```python
from pynq import Overlay
ol = Overlay("./imageProcess.bit")

from PIL import Image
from IPython.display import display

img = Image.open("./lena_gray.bmp")

import pynq.lib.dma
from pynq import Interrupt
from pynq import allocate
import numpy as np

dma = ol.axi_dma_0
dma_send = dma.sendchannel
dma_recv = dma.recvchannel

img_w = 512
img_h = 512
input_buffer = allocate(shape=(img_w,img_h), dtype=np.uint8)
output_buffer = allocate(shape=(img_w-2,img_h-2), dtype=np.uint8)

input_buffer[0:img_w*img_h] = np.array(img)
output_buffer[0:(img_w-2)*(img_h-2)] = np.full((510, 510), 0, dtype=np.uint8)

inbuf_image = Image.fromarray(input_buffer)
display(inbuf_image)
```

![!\[image\](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/lena_gray.bmp)](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/lena_gray.bmp)

```python
dma_send.transfer(input_buffer)
dma_recv.transfer(output_buffer)

outbuf_image = Image.fromarray(output_buffer)
outbuf_image.save('output.bmp')
display(outbuf_image)
```

## 模糊化
![!\[image\](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/output1.png)](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/output1.png)

## 曲線偵測
![!\[image\](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/output2.png)](https://github.com/Kevin18Chen/Image_processing_convolution3x3/tree/main/img/output2.png)
