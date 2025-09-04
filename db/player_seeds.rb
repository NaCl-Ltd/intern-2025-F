# Sample script to insert player data into the database

# Find or create some clubs first
club1 = Club.find_or_create_by(name: 'Tokyo FC')
club2 = Club.find_or_create_by(name: 'Osaka United')

# Insert players with club association
Player.create!(
  [
    { name: 'Taro Yamada', position: 'Forward', jersey_number: 9, nationality: 'Japan', age: 25, club: club1 },
    { name: 'Jiro Suzuki', position: 'Midfielder', jersey_number: 8, nationality: 'Japan', age: 27, club: club1 },
    { name: 'Ken Tanaka', position: 'Defender', jersey_number: 5, nationality: 'Japan', age: 30, club: club2 },
    { name: 'Shinji Kagawa', position: 'Midfielder', jersey_number: 10, nationality: 'Japan', age: 32, club: club2 }
  ]
)

puts "Players inserted successfully."