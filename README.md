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

# วิธีตั้งค่าสำหรับ FrontEnd Developer
## การวางไฟล์ SASS / SCSS
บริษัทฯเชื่อว่าซอฟต์แวร์คุณภาพเริ่มต้นจากโค๊ดที่เขียนขึ้นตามฟอร์แม่ทมาตรฐานสากล บริษัทฯใช้ GitLab ในการทำ Automated Testing เบื้องต้นในการลดภาระของ Software Tester ของบริษัทฯ และเป็นการช่วย Developer ในการตรวจสอบผลลัพธ์ก่อนส่งมอบงานได้แบบ Real Time โดยเข้าไปที่ `https://<project_name>.durian.software`

- กรุณาเก็บ SASS / SCSS SourceCode ของคุณใว้ที่ `resources/assets/BackOffice/<project_name>/<RESTful_action>.scss`
- ตั้งค่า Webpack สำหรับการ compile บนเซิร์ฟเวอร์ได้ที่ไฟล์ `webpack.mix.js` (ข้อมูลเพิ่มเติม และวิธีตั้งค่า Mix [คลิ๊ก](https://laravel.com/docs/master/mix))

## การวางไฟล์ JavaScript
เช่นเดียวกับ SASS / SCSS บริษัทฯใช้ GitLab ในการทำ Automated Testing เบื้องต้นในการลดภาระของ Software Tester ของบริษัทฯ และเป็นการช่วย Developer ในการตรวจสอบผลลัพธ์ก่อนส่งมอบงานได้แบบ Real Time

- กรุณาเก็บ Source Code ใว้ที่ `resources/assets/js/BackOffice/<project_name>/<RESTful_action>.js`
- ตั้งค่า Webpack สำหรับการ compile บนเซิร์ฟเวอร์ได้ที่ไฟล์ `webpack.mix.js`

## Corporate Identity (CI)
เพื่อให้การใช้สี ฟอนต์ ปุ่ม ช่องว่างระหว่าง component และอื่นๆ เป็นไปตาม Corporate Identity (CI) ที่ Designer ของบริษัทฯได้วางใว้ เจ้าหน้าที่ของบริษัทฯได้ทำปรับแต่งค่าของ CSS กลางใว้ให้แล้วซึ่ง FrontEnd Developer สามารถดูข้อมูลการตั้งค่าต่างๆได้จากไฟล์ CSS หลัก `sass/app.scss` หาก Developer มีความประสงค์จะปรับแต่งค่าของ CSS กลางนี้ ขอความกรุณาติดต่อที่เจ้าหน้าที่ผ่าน [FaceBook Pages](https://www.facebook/adiwitcoth)

## การวาง Routes
เราใช้ไฟล์ `routes/web.php` เพื่อ redirect URL จาก Browser ไปยังโมดูลปลายทางที่ถูกต้อง โปรดอย่าแก้ไขไฟล์นี้เพื่อป้องกันไม่ให้ส่งผลกระทบต่อ Developer ท่านอื่น ๆ ทั้งนี้หาก Developer มีความประสงค์จะปรับแต่งค่าของ Routes นี้ ขอความกรุณาติดต่อที่เจ้าหน้าที่ผ่าน [FaceBook Pages](https://www.facebook/adiwitcoth)

## การพัฒนา MockUp
เพื่อให้ Developer สามารถโฟกัสในการพัฒนา MockUp แต่ละหน้า เจ้าหน้าที่ของบริษัทฯได้ทำการตั้งค่าในส่วนของ Header, Footer และ Sidebar (ถ้ามี) ให้กับ Developer เรียบร้อยแล้วใว้ที่ไฟล์ `layouts/html5.blade.php`

โดย Developer แก้ไขในไฟล์ของตัวเองที่ `resources/view/BackOffice/<project_name>/<RESTful_action>.blade.php` สามารถเพิ่มไฟล์ในส่วนสำคัญต่างๆของหน้าได้ผ่าน section ที่เจ้าหน้าที่ของบริษัทฯได้เจาะใว้ให้ ดังนี้:

โค๊ดพิเศษที่ต้องการใส่เพิ่มเติมในส่วนของ `<head></head>` เช่น `<link>`, `<meta>`, `<title>` หรืออื่นๆ Developer สามารถใส่เพิ่มเติมได้ตามต้องการที่

```
@section('head')
    <link rel="stylesheet" href="{{ asset('css/<project_name>/<RESTful_action>.css') }}">
    <meta name="author" content="John Doe">
    <style>
        body {background-color: orange;}
    </style>
@endsection
```

โค๊ด `<script></script>` พิเศษที่ต้องการใส่เพิ่มเติมก่อนปิด `</body>` Developer สามารถใส่เพิ่มเติมได้ตามต้องการที่

```
@section('script')
    <script>
        function myFunction {
            document.getElementById("demo").innerHTML = "Hello JavaScript!";
        }
    </script>
    <script src="{{ asset('js/<project_name>/<RESTful_action>.js') }}">
@endsection
```

และสำหรับโค๊ด HTML ของหน้า

```
@section('body`)
    <div class="container-fluid">
    </div>
@endsection
```

## การ Compile งาน SaSS และ JavaScript
เช่นเดียวกับการพัฒนา MockUp โดยใช้ HTML ตามปกติ, Developer สามารถใช้ NPM หรือ YARN ในการ compile ไฟล์ SASS / SCSS / JavaScript ได้โดย `cd user` เข้าไปยังโฟลเดอร์ที่เก็บโค๊ดโปรแกรมของคุณ แล้วใช้คำสั่ง `npm run dev` หรือ `yarn run dev` แล้วเปิดดูผลงานของคุณผ่าน browser ที่ URL (http://localhost) 

---

# วิธีตั้งค่าสำหรับ BackEnd Developer
เราใช้ไฟล์ `routes/web.php` เพื่อ redirect URL จาก Browser ไปยังโมดูลปลายทางที่ถูกต้อง โปรดอย่าแก้ไขไฟล์นี้เพื่อป้องกันไม่ให้ส่งผลกระทบต่อ Developer ท่านอื่น ๆ ทั้งนี้หาก Developer มีความประสงค์จะปรับแต่งค่าของ Routes นี้ ขอความกรุณาติดต่อที่เจ้าหน้าที่ผ่าน [FaceBook Pages](https://www.facebook/adiwitcoth)

- โปรดตรวจสอบข้อมูล ไฟล์ ER Diagram ได้จาก resources/assets/ERDiagram/<project_name>.pdf

## การใช้งาน PHP Artisan จาก Docker
```
docker exec -it <project_name> php artisan migrate
```

## การใช้งาน PhpMyAdmin
ภายหลังจากที่ได้เปิดเซิร์ฟเวอร์จำลองขึ้นมาแล้ว Developer สามารถเข้าใช้งาน PHPMyAdmin ได้โดยเปิดผ่าน browser ที่ URL (http://localhost:8888) ข้อมูลเพิ่มเติมและวิธีใช้งาน Docker [คลิ๊ก](https://docs.docker.com/get-started)

## การวางไฟล์
บริษัทฯเชื่อว่าซอฟต์แวร์คุณภาพเริ่มต้นจากโค๊ดที่เขียนขึ้นตามฟอร์แม่ทมาตรฐานสากล บริษัทฯใช้ GitLab ในการทำ Automated Testing เบื้องต้นในการลดภาระของ Software Tester ของบริษัทฯ และเป็นการช่วย Developer ในการตรวจสอบผลลัพธ์ก่อนส่งมอบงานได้แบบ Real Time โดยเข้าไปที่ `https://<project_name>.durian.software`

### ไฟล์ Test
- กรุณาเก็บไฟล์ของคุณใว้ที่ `tests/Unit/BackOffice/<project_name>/` โดยแบ่งแยกตาม RESTful_action ดังนี้ :
    - <project_name>CreateTest.php
    - <project_name>DeleteTest.php
    - <project_name>DestroyTest.php
    - <project_name>ReadTest.php
    - <project_name>RestoreTest.php
    - <project_name>SearchTest.php
    - <project_name>UpdateTest.php

### ไฟล์ Migration
วิธีการตั้งชื่อไฟล์ ขอให้ตั้งชื่อตาม action ที่เกิดขึ้นโดยใช้ [snake_case](https://en.wikipedia.org/wiki/Snake_case) ตามคำแนะนำของ [Laravel](https://laravel.com/docs/5.5/migrations#generating-migrations) โดย Developer สามารถใช้คำสั่ง php artisan make:migration <database_action_name> -all ที่มาพร้อมกับ Laravel เพื่อช่วยในการสร้าง Migration นี้ได้ เช่น php artisan make:migration create_dim_examples_table หรือ php artisan make:migration add_companies_to_dim_examples_table เป็นต้น
- กรุณาเก็บไฟล์ของคุณใว้ที่ `databases/migrations/` โดยไม่ต้องใส่โฟลเดอร์ย่อยอะไรเพิ่มเติม
- โปรดตั้งชื่อ table ตามที่ระบุให้ใน ER Diagram

#### ไฟล์ Model
- กรุณาเก็บไฟล์ของคุณใว้ที่ `app/` โดยใช้ [PascalCase](https://en.wikipedia.org/wiki/PascalCase) ไม่ต้องใส่โฟลเดอร์ย่อยอะไรเพิ่มเติม
- ในกรณีที่ Developer ได้รับงานในโมดูลที่มี Relationship (ForeignKey, 1-to-many หรือ many-to-many) ขอความกรุณา Developer สร้าง Model เปล่าๆขึ้นมาเพื่อรองรับ และเพิ่ม function ที่เกี่ยวข้อง เช่น BelongsTo, HasMany, HasOne, ManyToMany เป็นต้น

#### ไฟล์ Seed
- กรุณาเก็บไฟล์ของคุณใว้ที่ `databases/seeds/BackOffice/<project_name>/` และขอความกรุณาใช้ Factory + Faker ในการสร้าง Seed โดยให้สร้างข้อทมูลตัวอย่าง อย่างน้อย 100 records

#### ไฟล์ Factory
- กรุณาเก็บไฟล์ของคุณใว้ที่ `databases/factories/<project_name>`

### ไฟล์ Controller
เพื่อให้ Developer ทำงานได้อย่างสะดวก สามารถปิดงานได้อย่างรวดเร็ว และย่นระยะเวลาการตรวจรับงานของทีมงานบริษัทฯ ขอความกรุณา Developer ใช้ [Resource Controller](https://laravel.com/docs/5.5/controllers#resource-controllers) โดยคำนึงถึงคอนเซ็ปต์ CRUD ในการเขียน Controller
- กรุณาเก็บไฟล์ของคุณใว้ที่ `app/Http/Controllers/BackOffice/` ในรูปแบบ [PascalCase](https://en.wikipedia.org/wiki/PascalCase) โดยไม่ต้องใส่โฟลเดอร์ย่อยอะไรเพิ่มเติม

ทีมงานของบริษัทฯเข้าใจดีว่า Resource Controller นั้นไม่ได้มี function ในส่วนของการ Restore และ ForceDelete ตามที่ระบุใน ER Diagram มาให้ จึงขอความกรุณา Developer เพิ่มเติมในส่วนของฟังก์ชั่น Restore ดังนี้:

```
/**
 * Restore the specified resource from Soft Deletion.
 *
 * @param  int  $id
 * @return \Illuminate\Http\Response
 */
public function restore($id)
{
    $model->relationship()->restore();
    return redirect()->route('<project_name>.index')->with('success', 'Restore success');
}
```

และเพิ่ม Route ดังนี้:
```
Route::get('<project_name>/{id}/restore', ['as' => '<project_name>.restore', 'uses' => 'BackOffice\<project_name>Controller@restore']);
```

สำหรับการทำ ForceDelete นั้นขอให้ ​Developer ใช้ฟังก์ชั่นเดียวกับการทำ softDelete กล่่าวคือให้ใช้ฟังก์ชั่น destroy ที่มาให้กับ Resource Controller อยู่แล้วดังนี้:

```
$model = Model::withTrashed()->where('id', 1)->first();
if ($model->trashed()) {
    return $model->relationship()->forceDelete();
}
return $model->relationship()->delete();
```

#### Nested Resources Controller
ในกรณีที่ Developer ได้รับโมดูลที่เชื่อมต่อกัน เช่น Post > Comments ขอความกรุณา Developer ใช้ [Nested Resource](https://laravel.com/docs/5.1/controllers#restful-nested-resources) เพื่อให้ Developer ทำงานได้อย่างสะดวก สามารถปิดงานได้อย่างรวดเร็ว และย่นระยะเวลาการตรวจรับงานของทีมงานบริษัทฯ

### ไฟล์ View
เนื่องจากบริษัทฯ แบ่งการทำงานระหว่าง BackEnd Developer ออกจาก FrontEnd Web Developer บริษัทฯจึงขอความกรุณา BackEnd Developer เขียน Code ในส่วนของ HTML, CSS, และ​ JavaScript ให้น้อยที่สุด โดยให้คำนึงว่าจุดประสงค์ของการเขียน​ View ในครั้งนี้คือแค่ให้เพียงพอที่ FrontEnd Developer (ผู้ซึ่งไม่ถนัด Logical Coding) สามารถหยิบ code ของคุณไปวางในที่ๆเหมาะสมได้อย่างง่ายดาย

```
<form action="{{ route('example.store') }}" method="POST">
    {!! csrf_field() !!}

    <!-- EXAMPLE SELECT -->
    <select name="field_1[]" id="field_1">
        <option value="" disabled="disabled">-- Field 1 --</option>
        <option value="{{ old('field_1')}}" @if( old('field_1')) selected="selected" @endif >Value 1</option>
        <option value="{{ old('field_1')}}" @if( old('field_1')) selected="selected" @endif >Value 2</option>
    </select>
    
    <!-- EXAMPLE INPUT -->
    <input type="text" name="field_2" id="field_2" placeholder="field_2" value="{{ old('field_2') }}" required>
    
    <!-- EXAMPLE TEXTAREA -->
    <textarea name="field_3" id="field_3" placeholder="field_3">{{ old('field_3') }}</textarea>

    <!-- EXAMPLE RADIO -->
    <input type="radio" name="field_4" value="1" id="field_4" @if( old('field_4')) checked @endif> Active
    <input type="radio" name="field_4" value="0" id="field_4" @if(! old('field_4')) checked @endif> Inactive

    <!-- EXAMPLE CHECKBOX -->
    <input type="checkbox" name="field_5[]" value="1" id="field_5" @if( old('field_5')) checked @endif> Active
    <input type="checkbox" name="field_5[]" value="0" id="field_5" @if(! old('field_5')) checked @endif> Inactive

    <button type="submit">Submit</button>
</form>

<!-- ERROR MESSAGES -->
<div>Error Message</div> 
```

- กรุณาเก็บไฟล์ของคุณใว้ที่ `resources/views/BackOffice/<project_name>/<RESTful_action>.blade.php`


### ไฟล์ Request (Validation และ ​Message)
- กรุณาเก็บไฟล์ของคุณใว้ที่ `app/Http/Requests/BackOffice/<project_name>/`

### ไฟล์รูป และไฟล์ต่างที่ user เป็นผู้อัปโหลดขึ้นมา
เพื่อป้องกันข้อมูลส่วนตัวของ User ขอความกรุณา Developer เซฟรูปใว้ที่ /storage/images/<project_name>s/ แล้วเรียกมาใช้ด้วยคำสั่ง return Image::make(storage_path('/images/project_name>s/') แทนที่จะเก็บใน public ข้อมูลเพิ่มเติม [คลิ๊ก](https://laracasts.com/discuss/channels/laravel/how-and-where-can-store-images-with-laravel?page=1) และกรุณาเก็บไฟล์แยกตามประเภทดังนี้ : ** ชื่อ folder มี s ต่อท้ายเป็นแบบ plural (พหูพจน์)
    - ไฟล์รูป เช่น JPG PNG GIF PSD AI กรุณาเก็บไฟล์ของ user ใว้ที่ storage/images/<project_name>s
    - ไฟล์เอกสาร เช่น DOC XLS PDF กรุณาเก็บไฟล์ของ user ใว้ที่ storage/documents/<project_name>s
    - ไฟล์ฟอนต์ เช่น OTF TTF EOF กรุณาเก็บไฟล์ของ user ใว้ที่ storage/fonts/<project_name>s
    - ไฟล์เพลง เช่น MP3 WAV กรุณาเก็บไฟล์ของ user ใว้ที่ storage/musics/<project_name>s
    - ไฟล์หนัง เช่น MP4 กรุณาเก็บไฟล์ของ user ใว้ที่ storage/movies/<project_name>s
    - ไฟล์อื่นๆ เช่น ZIP EXE MSI DMG กรุณาเก็บไฟล์ของ user ใว้ที่ storage/others/<project_name>s

## Scope งาน :
- UnitTest​
- Migration
- Model
- Seed
- Factory
- Controller
- Request (Validation และ ​Message)