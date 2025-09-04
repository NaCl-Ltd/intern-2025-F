require 'json'

# JSON data of players by club and season
players_json = <<-JSON
[
  {
  "club": "Liverpool",
  "season": "2025/26",
  "players": [
    {"number": 1,  "name": "Alisson Becker",      "position": "GK",   "age": 32},
    {"number": 25, "name": "Giorgi Mamardashvili","position": "GK",   "age": 24},
    {"number": 28, "name": "Freddie Woodman",     "position": "GK",   "age": 28},
    {"number": 41, "name": "Ármin Pécsi",         "position": "GK",   "age": 20},
    {"number": 2,  "name": "Joe Gomez",           "position": "DF",   "age": 28},
    {"number": 4,  "name": "Virgil van Dijk",     "position": "DF",   "age": 34},
    {"number": 5,  "name": "Ibrahima Konaté",     "position": "DF",   "age": 26},
    {"number": 6,  "name": "Milos Kerkez",        "position": "DF",   "age": 21},
    {"number": 12, "name": "Conor Bradley",       "position": "DF",   "age": 22},
    {"number": 15, "name": "Giovanni Leoni",      "position": "DF",   "age": 18},
    {"number": 26, "name": "Andy Robertson",       "position": "DF",   "age": 31},
    {"number": 30, "name": "Jeremie Frimpong",    "position": "DF",   "age": 24},
    {"number": 46, "name": "Rhys Williams",       "position": "DF",   "age": 24},
    {"number": 47, "name": "Calvin Ramsay",       "position": "DF",   "age": 22},
    {"number": 3,  "name": "Wataru Endo",         "position": "MF",   "age": 32},
    {"number": 8,  "name": "Dominik Szoboszlai", "position": "MF",   "age": 24},
    {"number": 10, "name": "Alexis Mac Allister", "position": "MF",   "age": 26},
    {"number": 17, "name": "Curtis Jones",        "position": "MF",   "age": 24},
    {"number": 38, "name": "Ryan Gravenberch",    "position": "MF",   "age": 23},
    {"number": 42, "name": "Trey Nyoni",          "position": "MF",   "age": 18},
    {"number": 43, "name": "Stefan Bajcetic",     "position": "MF",   "age": 20},
    {"number": 7,  "name": "Florian Wirtz",       "position": "FW",   "age": 22},
    {"number": 9,  "name": "Alexander Isak",      "position": "FW",   "age": 25},
    {"number": 11, "name": "Mohamed Salah",       "position": "FW",   "age": 33},
    {"number": 14, "name": "Federico Chiesa",     "position": "FW",   "age": 27},
    {"number": 18, "name": "Cody Gakpo",          "position": "FW",   "age": 26},
    {"number": 22, "name": "Hugo Ekitike",        "position": "FW",   "age": 23},
    {"number": 73, "name": "Rio Ngumoha",         "position": "FW",   "age": 16}
  ],
  "source": "Wikipedia squad table, as of 2025-08-xx"
}
]
JSON

data = JSON.parse(players_json)

data.each do |club_data|
  club_name = club_data["club"]
  club = Club.find_or_create_by(name: club_name)

  club_data["players"].each do |player|
    Player.create!(
      name: player["name"],
      position: player["position"],
      jersey_number: player["number"],
      age: player["age"],
      nationality: "Unknown",
      club: club
    )
  end
end

puts "Players imported successfully from JSON data."