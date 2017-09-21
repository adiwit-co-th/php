<a href="https://www.adiwit.co.th"><img src="http://www.adiwit.co.th/wp-content/uploads/logo.png" alt="Logo" width="80px"></a>

เราใช้ Docker เพื่อจำลองสภาพแวดล้อมเซิร์ฟเวอร์ให้กับคุณ ดังนั้นคุณจึงมั่นใจได้ว่าไฟล์บนเซิร์ฟเวอร์จะแสดงผลเหมือนกับเครื่องของคุณอย่างแน่นอน

- Docker CE [ดาวน์โหลด](https://www.docker.com/community-edition#/download).

## การใช้งาน Docker Container เบื้องต้น
เข้าไปยังโฟลเดอร์ที่เก็บโค๊ดโปรแกรมของคุณผ่าน `Shell`, `Terminal`, `Command Prompt` หรือ `Windows Power Shell`
- เปิดเซิร์ฟเวอร์จำลอง ใช้คำสั่ง `docker-compose up -d`
- ปิดเซิร์ฟเวอร์จำลอง ใช้คำสั่ง `docker-compose stop`
- ทำลายเซิร์ฟเวอร์จำลองโดยไม่ลบไฟล์ทิ้ง ใช้คำสั่ง `docker-compose rm -f`
- ดูรายการเซิร์ฟเวอร์จำลองที่เปิดค้างอยู่ ใช้คำสั่ง `docker ps -a`
- ดู Log ของเซิร์ฟเวอร์จำลอง ใช้คำสั่ง `docker logs <project_name>`

เปิดดูผลงานผ่าน browser ที่ URL (http://localhost) ข้อมูลเพิ่มเติมและวิธีใช้งาน Docker [คลิ๊ก](https://docs.docker.com/get-started)

## การตั้งค่า .ENV
[Laravel](https://laravel.com/docs/master/installation) เก็บข้อมูลการตั้งค่ารวมไปถึงรหัสความปลอดภัยต่างๆใว้ที่ .env อย่างไรก็ตามการเก็บไฟล์ .env ใว้บน Git SourceControl มีเความเสี่ยง เนื่องจากบุคคลที่ 3 สามารถเข้ามาใช้ค่านี้ในการเจาะระบบได้ เพื่อเป็นการลดความเสี่ยงนี้ บริษัทฯจึงขอความกรุณา Developer ก๊อปปี้ไฟล์ `.env.example ` ที่บริษัทฯได้ทำการตั้งค่าเบื้องต้นเพื่อใช้กับ docker ใว้แล้ว มาวางที่ `.env` โดยใช้คำสั่ง

```
cp .env.example .env
```

และสร้างรหัสความปลอดภัยของ Developer เอง โดยใช้คำสั่ง

```
docker exec -it <project_name> php artisan key:generate
```

ภายหลังจากที่ได้เปิดเซิร์ฟเวอร์จำลองขึ้นมาแล้ว

### ไฟล์รูป และไฟล์ต่างที่ user เป็นผู้อัปโหลดขึ้นมา
เพื่อป้องกันข้อมูลส่วนตัวของ User ขอความกรุณา Developer เซฟรูปใว้ที่ /storage/images/<project_name>s/ แล้วเรียกมาใช้ด้วยคำสั่ง return Image::make(storage_path('/images/project_name>s/') แทนที่จะเก็บใน public ข้อมูลเพิ่มเติม [คลิ๊ก](https://laracasts.com/discuss/channels/laravel/how-and-where-can-store-images-with-laravel?page=1) และกรุณาเก็บไฟล์แยกตามประเภทดังนี้ : 
- ชื่อ folder มี s ต่อท้ายเป็นแบบ plural (พหูพจน์)
- ไฟล์รูป เช่น JPG PNG GIF PSD AI กรุณาเก็บไฟล์ของ user ใว้ที่ storage/images/<project_name>s
- ไฟล์เอกสาร เช่น DOC XLS PDF กรุณาเก็บไฟล์ของ user ใว้ที่ storage/documents/<project_name>s
- ไฟล์ฟอนต์ เช่น OTF TTF EOF กรุณาเก็บไฟล์ของ user ใว้ที่ storage/fonts/<project_name>s
- ไฟล์เพลง เช่น MP3 WAV กรุณาเก็บไฟล์ของ user ใว้ที่ storage/musics/<project_name>s
- ไฟล์หนัง เช่น MP4 กรุณาเก็บไฟล์ของ user ใว้ที่ storage/movies/<project_name>s
- ไฟล์อื่นๆ เช่น ZIP EXE MSI DMG กรุณาเก็บไฟล์ของ user ใว้ที่ storage/others/<project_name>s

# คำแนะนำในการทำงาน การตั้งชื่อไฟล์ และการวางไฟล์ให้ถูกต้องตามโฟลเดอร์

- สำหรับ FrontEnd Developer [คลิ๊ก](FrontEndReadMe.md)
- สำหรับ BackEnd Developer [คลิ๊ก](BackEndReadMe.md)