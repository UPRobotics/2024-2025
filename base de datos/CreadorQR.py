import qrcode
qr = qrcode.QRCode(version=1, box_size=2, border=2)
data = input("Enter your data: ")
qr.add_data(data)
qr.make(fit=True)
img = qr.make_image(fill_color="black", back_color="white")
img.save("qrcode2.png")