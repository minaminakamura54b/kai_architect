# 既存データをリセット（再実行しても重複しないよう）
BusinessTrip.destroy_all
Inspection.destroy_all
Site.destroy_all
User.destroy_all

# ============================================================
# ユーザー
# ============================================================
user1 = User.create!(
  name:  "中村 南",
  email: "nakamura@example.com",
  password:              "Password1",
  password_confirmation: "Password1",
  role: :admin
)

user2 = User.create!(
  name:  "田中 健太",
  email: "tanaka@example.com",
  password:              "Password1",
  password_confirmation: "Password1",
  role: :worker
)

user3 = User.create!(
  name:  "佐藤 美咲",
  email: "sato@example.com",
  password:              "Password1",
  password_confirmation: "Password1",
  role: :worker
)

# ============================================================
# 現場
# ============================================================
site1 = Site.create!(
  name:        "渋谷オフィスビル新築工事",
  address:     "東京都渋谷区渋谷2-1-5",
  status:      :active,
  description: "地上15階・地下2階建ての複合オフィスビル。2026年12月竣工予定。"
)

site2 = Site.create!(
  name:        "横浜倉庫改修工事",
  address:     "神奈川県横浜市港北区新横浜3-8-12",
  status:      :active,
  description: "既存倉庫の耐震補強および内装改修工事。"
)

site3 = Site.create!(
  name:        "品川マンション外壁修繕",
  address:     "東京都品川区大崎1-11-3",
  status:      :completed,
  description: "外壁タイルの剥落防止・防水処理工事。2026年3月完了。"
)

site4 = Site.create!(
  name:        "新宿商業施設内装工事",
  address:     "東京都新宿区西新宿6-14-1",
  status:      :suspended,
  description: "テナント退去に伴う内装解体・原状回復工事。施主都合により一時停止中。"
)

# ============================================================
# 日報（ページネーション確認のため20件以上作成）
# ============================================================
inspection_data = [
  # site1 の日報
  { site: site1, user: user1, inspected_at: 25.days.ago,
    result: "基礎コンクリート打設完了。強度試験の結果は基準値を満たしており、問題なし。養生期間を経て次工程へ移行予定。",
    remarks: "試験体3本採取済み。7日・28日後に再確認。" },
  { site: site1, user: user2, inspected_at: 22.days.ago,
    result: "1階鉄骨建方作業を実施。柱・梁の接合部ボルト締め付け完了。垂直精度は±2mm以内で合格。",
    remarks: "明日から2階の建方開始予定。" },
  { site: site1, user: user1, inspected_at: 18.days.ago,
    result: "2〜4階の鉄骨建方完了。溶接検査を実施し、全箇所合格判定。足場の組み換え作業も完了。",
    remarks: nil },
  { site: site1, user: user3, inspected_at: 15.days.ago,
    result: "5階・6階の床スラブコンクリート打設。打設量：220m³。天候良好により予定通り進行。",
    remarks: "脱型は3日後を予定。" },
  { site: site1, user: user2, inspected_at: 12.days.ago,
    result: "7〜9階の外壁型枠組み立て作業中。進捗率70%。風の影響で一部作業を翌日に繰り越し。",
    remarks: "型枠材の追加発注済み（納期3日後）。" },
  { site: site1, user: user1, inspected_at: 8.days.ago,
    result: "外壁型枠組み立て完了。検査立会いを実施し、配筋・型枠のかぶり厚さを確認。一部是正箇所あり。",
    remarks: "是正後に再検査予定。担当：田中、佐藤。" },
  { site: site1, user: user3, inspected_at: 5.days.ago,
    result: "10〜12階の建方準備。資材搬入および揚重機配置の確認を行った。天候不良のため着手は翌週予定。",
    remarks: "クレーン手配済み。" },
  { site: site1, user: user1, inspected_at: 2.days.ago,
    result: "工程会議を実施。発注者・設計事務所との定例打合せにて、仕上げ材の変更について協議。変更指示書を受領待ち。",
    remarks: "変更指示受領後に工程再調整が必要。" },

  # site2 の日報
  { site: site2, user: user2, inspected_at: 30.days.ago,
    result: "既存倉庫の現況調査完了。ひび割れ箇所の記録と写真撮影を実施。大きな損傷は東面外壁に集中している。",
    remarks: "詳細調査報告書は来週提出予定。" },
  { site: site2, user: user1, inspected_at: 26.days.ago,
    result: "耐震診断の結果を踏まえた補強設計の確認を実施。Is値0.6未満の箇所について補強計画を再検討。",
    remarks: "構造設計事務所と協議要。" },
  { site: site2, user: user3, inspected_at: 20.days.ago,
    result: "鉄骨ブレース取付け工事を開始。予定箇所の半分が完了。溶接部の超音波探傷試験を並行実施。",
    remarks: nil },
  { site: site2, user: user2, inspected_at: 14.days.ago,
    result: "鉄骨ブレース工事完了。内壁の断熱材撤去および新規断熱材の施工を開始。アスベスト含有材なし（分析済み）。",
    remarks: "廃材は分別して処分。マニフェスト管理済み。" },
  { site: site2, user: user1, inspected_at: 7.days.ago,
    result: "内装ボード張り工事進捗50%。電気設備の配管・配線工事と並行して進めているため工程調整が必要。",
    remarks: "設備業者との工程調整MTGを来週予定。" },
  { site: site2, user: user3, inspected_at: 1.day.ago,  status: :not_started,
    result: "仕上げ塗装工事の着手準備。下地処理の確認を行った。一部に水分含有量が高い箇所があり、乾燥待ちが必要。",
    remarks: "塗装着手は3日後以降。" },

  # site3 の日報（完了現場）
  { site: site3, user: user2, inspected_at: 90.days.ago,
    result: "外壁全面打診調査完了。浮き・剥落箇所を130か所記録。優先度別に補修計画を策定。",
    remarks: nil },
  { site: site3, user: user1, inspected_at: 75.days.ago,
    result: "高所作業車によるタイル張替え工事完了（優先箇所）。防水処理の施工も並行して完了。",
    remarks: "仕上がり確認写真を施主に提出済み。" },
  { site: site3, user: user3, inspected_at: 60.days.ago,
    result: "全補修箇所の竣工検査を実施。発注者・管理組合立会いのもと確認を行い、合格判定。工事完了報告書を提出。",
    remarks: "保証書・引渡し書類を郵送済み。" },

  # site4 の日報（停止中現場）
  { site: site4, user: user1, inspected_at: 45.days.ago,
    result: "既存テナント退去後の内覧を実施。残置物の確認と解体範囲の確定を行った。石綿含有調査は問題なし。",
    remarks: nil },
  { site: site4, user: user2, inspected_at: 40.days.ago,
    result: "解体工事着手準備。仮設設備の設置と防音シートの取付けを完了した段階で施主より工事一時停止の連絡。",
    remarks: "停止理由：施主側の資金調達スケジュールの変更。再開は未定。" },
  { site: site4, user: user1, inspected_at: 35.days.ago,
    result: "現場保全のための定期確認。設置済みの仮設設備に異常なし。防音シート・養生材の状態も良好。",
    remarks: "月1回の定期パトロールを継続。" },
]

inspection_data.each do |data|
  Inspection.create!(data)
end

# ============================================================
# 出張報告
# ============================================================
business_trip_data = [
  { site: site1, user: user1,
    started_at: 20.days.ago, ended_at: 20.days.ago,
    destination: "東京都渋谷区",
    purpose:     "発注者との定例工程打合せ",
    report:      "工程の進捗確認および設計変更の協議を実施。変更指示書は来週中に発行予定。次回定例は2週間後。",
    expenses:    3500 },
  { site: site1, user: user2,
    started_at: 17.days.ago, ended_at: 16.days.ago,
    destination: "大阪府大阪市",
    purpose:     "鉄骨製作工場での品質検査立会い",
    report:      "工場にて鉄骨部材の製作状況を確認。溶接部の外観検査・寸法検査ともに合格。搬入は来月上旬の予定。",
    expenses:    28000 },
  { site: site1, user: user3,
    started_at: 10.days.ago, ended_at: 10.days.ago,
    destination: "東京都千代田区",
    purpose:     "建築確認申請に関する行政協議",
    report:      "指定確認検査機関にて中間検査の事前協議を実施。提出書類の不備なし。検査は来月初旬に予定。",
    expenses:    1200 },
  { site: site2, user: user2,
    started_at: 28.days.ago, ended_at: 28.days.ago,
    destination: "神奈川県横浜市",
    purpose:     "耐震補強設計事務所との協議",
    report:      "補強計画の詳細について構造設計事務所と協議。Is値改善計画を確定。施工図の修正を依頼。",
    expenses:    2800 },
  { site: site2, user: user1,
    started_at: 19.days.ago, ended_at: 18.days.ago,
    destination: "埼玉県さいたま市",
    purpose:     "断熱材メーカーへの工場視察",
    report:      "高性能断熱材の施工方法確認のため工場見学を実施。今回採用製品の標準施工手順書を入手。",
    expenses:    18500 },
  { site: site2, user: user3,
    started_at: 9.days.ago, ended_at: 9.days.ago,
    destination: "神奈川県横浜市",
    purpose:     "設備業者との工程調整打合せ",
    report:      "電気・空調・給排水各業者と工程の重複箇所を確認。調整後の統合工程表を作成し合意を得た。",
    expenses:    1500 },
  { site: site3, user: user1,
    started_at: 85.days.ago, ended_at: 85.days.ago,
    destination: "東京都品川区",
    purpose:     "管理組合との工事説明会",
    report:      "施工範囲・工事期間・騒音対策について説明。居住者への周知文書を配布。質疑応答にて懸念事項を解消。",
    expenses:    800 },
  { site: site3, user: user2,
    started_at: 71.days.ago, ended_at: 70.days.ago,
    destination: "愛知県名古屋市",
    purpose:     "外壁タイルメーカーとの色合わせ確認",
    report:      "既存タイルとの色・質感の照合を工場にて実施。3種類のサンプルを持ち帰り施主に確認依頼。",
    expenses:    22000 },
  { site: site4, user: user1,
    started_at: 42.days.ago, ended_at: 42.days.ago,
    destination: "東京都新宿区",
    purpose:     "施主との停止理由確認・今後の協議",
    report:      "施主より工事一時停止の正式通知を受領。再開見通しは未定。現場保全費用の精算について協議継続。",
    expenses:    0 },
]

business_trip_data.each do |data|
  BusinessTrip.create!(data)
end

puts "シード完了:"
puts "  ユーザー  : #{User.count}名"
puts "  現場      : #{Site.count}件"
puts "  日報      : #{Inspection.count}件"
puts "  出張報告  : #{BusinessTrip.count}件"
