class CapturedImage < ApplicationRecord
  mount_uploader :content, ContentUploader

  enum status: [:main, :sub]

  belongs_to :prototype, optional: true
  # optional: trueをつけている理由は、railsの5系からbelongs_toの設定が変わり、DBに保存されるまでは、prototypeのidはnilなので、つまり、imageモデルでの時点では、prototype_id（imageレコードの外部キー）はnilなので、 required:trueのバリデーションに引っかかり、保存されなかったということになるらしい。
  # ImageはProduct保存後でないと親レコードのIDが決まらないので保存できない。
  # なので、prototypeのidがnilでもoptional: trueという設定で、imageを保存できるようにしてあげてます。
end
