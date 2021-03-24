#pragma once
#ifndef TRT_YOLO_H
#define TRT_YOLO_H
#include "NvInfer.h"
class TrtYolo
{
private:
    nvinfer1::IExecutionContext i;
public:
    TrtYolo(/* args */);
    ~TrtYolo();
};
#endif //TRT_YOLO_H
