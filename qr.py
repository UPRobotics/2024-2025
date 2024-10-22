import cv2
import numpy as np
from pyzbar.pyzbar import decode
import time


cap = cv2.VideoCapture(0)

#tamaño de la camara

frameWidth = 640
frameHeight = 480

cap.set(3,frameWidth)
cap.set(4,frameHeight)

#configuraciones de video 

#Brillo

brillo = 100

cap.set(10,brillo)

#controls
def empty(a):
        pass
cv2.namedWindow("TrackBars")
cv2.resizeWindow("TrackBars",640,240)
cv2.createTrackbar("Hue min","TrackBars",0,179,empty)
cv2.createTrackbar("Hue max","TrackBars",179,179,empty)
cv2.createTrackbar("Sat min","TrackBars",0,255,empty)
cv2.createTrackbar("Sat max","TrackBars",255,255,empty)
cv2.createTrackbar("Val min","TrackBars",0,255,empty)
cv2.createTrackbar("Val max","TrackBars",255,255,empty)

while True:
   #video
    
    success, img = cap.read()

    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    img_C = cv2.Canny(img,100,100)


    #controles
    h_min = cv2.getTrackbarPos("Hue min","TrackBars")
    h_max = cv2.getTrackbarPos("Hue max","TrackBars")
    s_min = cv2.getTrackbarPos("Sat min","TrackBars")
    s_max = cv2.getTrackbarPos("Sat max","TrackBars")
    v_min = cv2.getTrackbarPos("Val min","TrackBars")
    v_max = cv2.getTrackbarPos("Val max","TrackBars")

    lower = np.array([h_min,s_min,v_min])
    upper = np.array([h_max,s_max,v_max])

    mask = cv2.inRange(img,lower,upper)

    #tiempo

    star= time.perf_counter()

    seconds = time.time()

    #imagen 1
    
    for barcode in decode(img):
        myData = barcode.data.decode('utf-8')
        print(myData)
        pts = np.array([barcode.polygon],np.int32)
        pts = pts.reshape((-1,1,2))
        cv2.polylines(img,[pts],True,(255,0,255),5)
        pts2 = barcode.rect
        cv2.putText(img,myData,(pts2[0],pts2[1]),cv2.FONT_HERSHEY_SIMPLEX, 0.9,(255,0,255),2)

    
    #imagen gris

    for barcode in decode(img_gray):
        myData = barcode.data.decode('utf-8')
        print(myData + " Gray")
        pts = np.array([barcode.polygon],np.int32)
        pts = pts.reshape((-1,1,2))
        cv2.polylines(img_gray,[pts],True,(255,255,255),5)
        pts2 = barcode.rect
        cv2.putText(img_gray,myData,(pts2[2],pts2[3]),cv2.FONT_HERSHEY_SIMPLEX, 0.9,(255,255,255),2)
    
    for barcode in decode(mask):
        myData = barcode.data.decode('utf-8')
        print(myData+" mask")
        pts = np.array([barcode.polygon],np.int32)
        pts = pts.reshape((-1,1,2))
        cv2.polylines(mask,[pts],True,(255,255,255),5)
        pts2 = barcode.rect
        cv2.putText(mask,myData,(pts2[4],pts2[5]),cv2.FONT_HERSHEY_SIMPLEX, 0.9,(255,255,255),2)

        if(myData != ""):
             print("No se detecta")





    cv2.imshow("Video_Gray",img_gray)
    cv2.imshow("Video",img)
    cv2.imshow("Video_mask",mask)

    if cv2.waitKey(1) & 0xFF ==ord('q'):
        print(seconds)

        break

