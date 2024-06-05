# frozen_string_literal: true

nakajima = User.create!(
  email: 'nakajima@example.com',
  name: 'nakajima',
  password: 'passpass',
  confirmed_at: Time.zone.now
)

nbc = Group.create!(
  name: '中島ブートキャンプ',
  description: <<-DESC
    中島県中島市のプログラミングスクールです。
    ---
    ---
    ---
    ---
    ---
    それほどお馳走で思わようたお話はなるしまっんて、その事にお霧受合でしませ。その一般はここ末がなりと次第でも思うとくれるのかあるですましから、その以上皆がうてあなたの秩序でしばいと、濫用をなりれるのは、個人の諸君においてせっかく必要たなてそこはしているものまして、だからためをあっと、さらに私方の意見構わようでない圧迫は、おっつけ私をその道がするていらっしゃるては面倒に関しれる事なけれはただとは出れのな。あなた麦飯がはそうしてそれの一つに敵まし知れのたはなれますましか。
  DESC
)

Invitation.create!({ group: nbc, token: 'gotonakajima' })

Membership.create!(
  user: nakajima,
  group: nbc,
  admin: true
)

30.times do |n|
  member = User.create!(
    email: "nbc_student#{n}@example.com",
    name: "nbc_student#{n}",
    password: 'passpass',
    confirmed_at: Time.zone.now
  )
  Membership.create!(
    user: member,
    group: nbc
  )
end

channel1 = Channel.create!({ group: nbc, title: '中島ブートキャンプへようこそ', description: '学習を始めるにあたっての必要事項を説明します。' })
channel2 = Channel.create!({ group: nbc, title: '中島Radio', description: '毎週水曜日に更新します。' })

50.times do |n|
  Channel.create!(
    group: nbc,
    title: "素晴らしい番組#{n}",
    description: <<-DESC
      ページネーションの確認に使います
      Id venenatis a condimentum vitae. Viverra aliquet eget sit amet tellus cras. Tempus urna et pharetra pharetra massa massa ultricies mi quis. Imperdiet dui accumsan sit amet. Lectus quam id leo in vitae turpis massa sed. Phasellus egestas tellus rutrum tellus. Amet dictum sit amet justo donec enim. Tellus elementum sagittis vitae et leo duis ut. Pellentesque habitant morbi tristique senectus. Orci dapibus ultrices in iaculis nunc sed augue lacus. Nunc aliquet bibendum enim facilisis gravida neque convallis a. Lacus sed viverra tellus in hac habitasse. Quis enim lobortis scelerisque fermentum dui. Nullam eget felis eget nunc lobortis mattis. Rutrum tellus pellentesque eu tincidunt. Ut lectus arcu bibendum at varius vel pharetra vel turpis. Phasellus egestas tellus rutrum tellus pellentesque eu. Nunc lobortis mattis aliquam faucibus purus in. Non sodales neque sodales ut etiam sit amet nisl purus. In fermentum et sollicitudin ac orci phasellus egestas tellus.
    DESC
  )
end

50.times do |n|
  episode = Episode.new(
    channel: channel1,
    title: "第#{n}回のエピソード",
    created_at: 52.days.ago + n.days,
    updated_at: 50.days.ago + n.days,
    description: <<-DESC
      また自由がはこういう人心の重宝具合に今にするた頃が見るからどうしても道楽云っからならすべてを越せのた。また何はこのためが食わせ通り越しのごとく、表裏の順序を反対分りです仕方をもできですたのにないはありべきた。同時に何はその必要ます自分になりまでです、使用の人格に至極切り開いうで起って行っだのあっ。毫もじっと五二一時間のありたて、壁がは権力をは何を坊ちゃんを上っでしてしだものを飛びなくう。しかし先刻全く校長がきまらからおきたでて、損害がとこう記憶のようです。
    DESC
  )
  path = Rails.root.join('db/seeds/audio1.m4a')
  episode.enclosure.attach(io: File.open(path), filename: 'audio1.m4a', content_type: 'audio/mp4')
  episode.save!
end

10.times do |n|
  episode = Episode.new(
    channel: channel2,
    title: "ep.#{n} #{n + 1}月#{n + 1}日",
    description: '必聴です',
    created_at: 2.weeks.ago + n.days,
    updated_at: 2.weeks.ago + n.days
  )
  path = Rails.root.join('db/seeds/audio1.m4a')
  episode.enclosure.attach(io: File.open(path), filename: 'audio1.m4a', content_type: 'audio/mp4')
  episode.save!
end
