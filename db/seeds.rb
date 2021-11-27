# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.find_or_create_by(email: ENV.fetch("ADMIN_EMAIL")) do |user|
#   puts "Seeding Admin User"
#   user.password = ENV.fetch("ADMIN_PASSWORD")
#   user.first_name = ENV.fetch("ADMIN_FIRST_NAME")
#   user.last_name = ENV.fetch("ADMIN_LAST_NAME")
#   user.admin = true
# end

User.connection

User.create(email: "admin@foo.bar",  first_name: "Alan",   last_name: "Admin",  admin: true, password: "admin1") unless User.find_by(email: "admin@foo.bar").present?
User.create(email: "worker@foo.bar", first_name: "Wilbur", last_name: "Worker", admin: nil, password: "worker1") unless User.find_by(email: "worker@foo.bar").present?
User.create(email: "rando@foo.bar",  first_name: "Marlon", last_name: "Rando",  admin: nil, password: "rando1") unless User.find_by(email: "rando@foo.bar").present?

# words = %w(apollo able baker delta epsilon)

words = ["24-hour safe trajectory", "4Frontiers Corp", "4th Planet Logistics",
         "90-day plan", "AACS", "A-arm ", "ablation", "Able", "Able/Baker",
         "abort to orbit", "abort zone", "acceleration", "ACE",
         "acquisition of signal", "B612 Foundation", "back-contamination",
         "background radiation CMB", "Baikonur Cosmodrome", "Baker",
         "Baker, Ellen S", "Baker, Michael", "c", "cabin pressure",
         "Caelus Partners", "callout", "Camarda, Charles", "Cameron, Kenneth D",
         "Canadarm", "Canadian Lunar Research Network", "Canadian Space Agency",
         "Canadian Space Society", "canard fin", "Daily Moon Position",
         "Danish National Space Center	DRC", "Darian calendar", "DART",
         "DAS", "Davis, Nancy Jan", "Dawn", "Dawn  ", "DCAM-3", "debriefing",
         "declination", "Eagle", "Earth Seed", "earth-crossing", "Earthshine",
         "eccentricity", "ecliptic", "ECLSS", "EDL", "Edwards AFB", "FAA",
         "Fabian, John", "faceplate", "fairing", "g", "G constant",
         "Gaffney, F Drew", "Gaganyaan", "Gagarin, Yuri", "Gaia",
         "galactic cosmic radiation (GCR)", "habitable zone (Goldilocks)",
         "Hadfield, Chris", "Hague, Nick", "Haigneré, Claudie",
         "Haigneré, Jean-Pierre", "Haipeng, Jing", "Haise, Fred", "IAF",
         "IAU", "ICBM", "ICE", "ICRF", "ICRS", "IERS", "IEVA", "ignition source",
         "James Webb Space Telescope", "Janet’s Planet", "Jankowski, Zenon",
         "JAXA", "Jemison, Mae", "Kadeniuk, Leonid", "Kaleri, Alexander",
         "kapton", "Karmann Line", "Kavandi, Janet L",
         "Kazakh Space Research Institute", "keepout sphere", "L5 Society",
         "Lagrange points L1-L5", "Laika", "lander", "Mach number",
         "Mackay, David", "MacLean, Steven", "Made in Space", "Magellan",
         "magnetometer", "NACA ", "nadir", "Nagel, Steven R", "Naro family",
         "NASA", "OB", "Oberth’s Law", "occultation", "Ochoa, Ellen",
         "Ockels, Wubbo", "O'Connor, Bryan", "OCSS", "Pad 39A", "pad team",
         "Padalka, Gennady", "Paektusan-1 - Retired", "Pailes, William",
         "Pakistan Space and Upper Atmosphere Research Commission",
         "quad (portion of Crew Dragon)", "Quan, Chen", "quarantine",
         "Quindar tones", "R-29 derivatives", "R-36 derivatives", "RA",
         "rad", "radiation hardening (space hardening)", "Sabatier process",
         "Sacco, Albert", "SAF", "Salyut", "T-minus", "taikonaut", "Tani, Daniel",
         "Tanner, Joseph", "tardigrade (water bear)", "UHF", "UK Space Agency",
         "ULA", "ultraviolet", "Ulysses", "umbilical", "V-2", "VAB",
         "vacuum", "Van Allen Belt", "Vanguard", "Wakata, Koichi",
         "Wake Forest Institute for Regenerative Medicine",
         "Walheim, Rex", "Walker, Charles D", "Walker, David M",
         "walking orbit", "X Prize, Ansari", "X Prize Cup", "X-15", "X-37B",
         "X-band", "X-rays", "Yang, Liu", "Yang Liwei", "yaw", "Yegorov, Boris",
         "Zalyotin, Sergei", "Zamka, George D", "Zenit", "zenith",
         "Zero Gravity Solutions"]

words.each do |word|
  Word.find_or_create_by(word: word) do |word|
    puts "Seeding Word: #{word.word}"
    word.status = "unclaimed"
  end
end
