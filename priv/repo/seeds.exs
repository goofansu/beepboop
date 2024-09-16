alias Beepboop.Repo
alias Beepboop.Athletes.Athlete

%Athlete{
  name: "Mike",
  emoji: "🏄‍♂️",
  sport: "Surfing",
  status: :training
}
|> Repo.insert!()

%Athlete{
  name: "Nicole",
  emoji: "🏊‍♀️",
  sport: "Swimming",
  status: :competing
}
|> Repo.insert!()

%Athlete{
  name: "Brin",
  emoji: "🏄🏽",
  sport: "Surfing",
  status: :competing
}
|> Repo.insert!()

%Athlete{
  name: "Alex",
  emoji: "🚣🏽",
  sport: "Rowing",
  status: :resting
}
|> Repo.insert!()

%Athlete{
  name: "Summer",
  emoji: "🏄🏾‍♀️",
  sport: "Surfing",
  status: :resting
}
|> Repo.insert!()

%Athlete{
  name: "Jason",
  emoji: "🚣‍♂️",
  sport: "Rowing",
  status: :competing
}
|> Repo.insert!()

%Athlete{
  name: "Logan",
  emoji: "🏊🏼‍♂️",
  sport: "Swimming",
  status: :training
}
|> Repo.insert!()

%Athlete{
  name: "Lina",
  emoji: "🚣‍♀️",
  sport: "Rowing",
  status: :training
}
|> Repo.insert!()

%Athlete{
  name: "Katie",
  emoji: "🏊",
  sport: "Swimming",
  status: :resting
}
|> Repo.insert!()
