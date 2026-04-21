# テーブル設計

## users table
| Column             | Type                | Options                   |
|---------------------|--------|-------------------------|
| nickname            | string | null: false              |
| email               | string | null: false, unique: true|
| encrypted_password  | string | null: false              |
| last_name           | string | null: false              |
| first_name          | string | null: false              |
| last_name_kana      | string | null: false              |
| first_name_kana     | string | null: false              |
| birth_date          | date   | null: false              |

### Association
has_many :items
has_many :orders


## items table
| Column             | Type                | Options                   |
|--------------------------|----------|--------------------------------|
| name                     | string   | null: false                     |
| description              | text     | null: false                     |
| price                    | integer  | null: false                     |
| category_id             | integer  | null: false                     |
| condition_id            | integer  | null: false                     |
| shipping_fee_burden_id  | integer  | null: false                     |
| prefecture_id           | integer  | null: false                     |
| shipping_day_id         | integer  | null: false                     |
| user_id                 | bigint   | null: false, foreign_key: true  |

### Association
belongs_to :user
has_one :order


## orders table
| Column             | Type                | Options                   |
|--------------------|------------|---------------------|
| user_id    | bigint   | null: false, foreign_key: true|
| item_id    | bigint   | null: false, foreign_key: true|

### Association
belongs_to :user
belongs_to :item
has_one :address



## addresses table
| Column             | Type                | Options                   |
|-------------------------------------|------------|--------------------------------|
| order_id       | bigint   | null: false, foreign_key: true|
| postal_code    | string   | null: false                    |
| prefecture_id  | integer  | null: false                    |
| city           | string   | null: false                    |
| street_address | string   | null: false                    |
| building_name  | string   |                                |
| phone_number   | string   | null: false                    |

### Association
belongs_to :order

