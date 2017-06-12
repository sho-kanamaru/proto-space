# Tables and Association of Protospace

## users table
### association
has_many :comments  
has_many :prototypes  
has_many :likes  

### table
|column|type|constraint|index|
|:---:|:---:|:---:|:---:|
|name|string|null:false|-|
|image|string|-|-|
|group|string|-|-|
|profile|text|-|-|
|email|string|null:false, unique: true|-|
|password|string|null:false, unique: true|-|

## prototypes table
### association
has_many :comments, dependent: :destroy  
has_many :captured_images, dependent: :destroy  
has_many :likes, dependent: :destroy  
belongs_to :user  

### table
|column|type|constraint|index|
|:---:|:---:|:---:|:---:|
|title|string|null:false|-|
|catch_copy|text|-|-|
|concept|text|-|-|
|user_id|integer|foreign_key :true|-|
|likes_count|integer|-|-|

## captured_images table
### association
belongs_to :prototype  

### table
|column|type|constraint|index|
|:---:|:---:|:---:|:---:|
|content|string|null:false|-|
|prototype_id|integer|foreign_key :true|-|

## likes table
### association
belongs_to :prototype, counter_cache: :likes_count  
belongs_to :user  

### table
|column|type|constraint|index|
|:---:|:---:|:---:|:---:|
|user_id|integer|foreign_key :true|-|
|prototype_id|integer|foreign_key :true|-|

## comments table
### association
belongs_to user  
belongs_to prototype  

### table
|column|type|constraint|index|
|:---:|:---:|:---:|:---:|
|content|text|null:false|-|
|user_id|integer|foreign_key :true|-|
|prototype_id|integer|foreign_key :true|-|

