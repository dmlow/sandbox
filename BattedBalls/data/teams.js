// team colors from here: http://teamcolors.arc90.com/

var teams = [
    {
        "name": "Giants",
        "shortName": "SFG",
        "league": "National",
        "division": "West",
        "color1": "#000000",
        "color2": "#F2552C"
    },
    {
        "name": "Dodgers",
        "shortName": "LAD",
        "league": "National",
        "division": "West",
        "color1": "#083C6B",
        "color2": "#FFFFFF"
    },
    {
        "name": "Diamondbacks",
        "shortName": "AZD",
        "league": "National",
        "division": "West",
        "color1": "#A71930",
        "color2": "#000000"
    },
    {
        "name": "Rockies",
        "shortName": "COL",
        "league": "National",
        "division": "West",
        "color1": "#000000",
        "color2": "#333366"
    },
    {
        "name": "Padres",
        "shortName": "SFG",
        "league": "National",
        "division": "West",
        "color1": "#002147",
        "color2": "#FFFFFF"
    },
    {
        "name": "Reds",
        "shortName": "CIN",
        "league": "National",
        "division": "Central",
        "color1": "#C6011F",
        "color2": "#FFFFFF"
    },
    {
        "name": "Cardinals",
        "shortName": "STL",
        "league": "National",
        "division": "Central",
        "color1": "#c41e3a",
        "color2": "#0A2252"
    },
    {
        "name": "Pirates",
        "shortName": "PIT",
        "league": "National",
        "division": "Central",
        "color1": "#000000",
        "color2": "#FFBF00"
    },
    {
        "name": "Brewers",
        "shortName": "MIL",
        "league": "National",
        "division": "Central",
        "color1": "#182B49",
        "color2": "#92754C"
    },
    {
        "name": "Cubs",
        "shortName": "CHC",
        "league": "National",
        "division": "Central",
        "color1": "#003279",
        "color2": "#CC0033"
    },
    {
        "name": "Nationals",
        "shortName": "WSH",
        "league": "National",
        "division": "East",
        "color1": "#BA122B",
        "color2": "#11225B"
    },
    {
        "name": "Braves",
        "shortName": "ATL",
        "league": "National",
        "division": "East",
        "color1": "#002F5F",
        "color2": "#B71234"
    },
    {
        "name": "Phillies",
        "shortName": "PHI",
        "league": "National",
        "division": "East",
        "color1": "#BA0C2F",
        "color2": "#FFFFFF"
    },
    {
        "name": "Mets",
        "shortName": "NYM",
        "league": "National",
        "division": "East",
        "color1": "#002C77",
        "color2": "#FB4F14"
    },
    {
        "name": "Marlins",
        "shortName": "MIA",
        "league": "National",
        "division": "East",
        "color1": "#0077C8",
        "color2": "#FFD100"
    },
    {
        "name": "Athletics",
        "shortName": "OAK",
        "league": "American",
        "division": "West",
        "color1": "#003831",
        "color2": "#FFD800"
    },
    {
        "name": "Rangers",
        "shortName": "TEX",
        "league": "American",
        "division": "West",
        "color1": "#BD1021",
        "color2": "#003279"
    },
    {
        "name": "Angels",
        "shortName": "LAA",
        "league": "American",
        "division": "West",
        "color1": "#B71234",
        "color2": "#002244"
    },
    {
        "name": "Mariners",
        "shortName": "SEA",
        "league": "American",
        "division": "West",
        "color1": "#0C2C56",
        "color2": "#005C5C"
    },
    {
        "name": "Astros",
        "shortName": "HOU",
        "league": "American",
        "division": "West",
        "color1": "#072854",
        "color2": "#FF7F00"
    },
    {
        "name": "Tigers",
        "shortName": "DET",
        "league": "American",
        "division": "Central",
        "color1": "#001742",
        "color2": "#DE4406"
    },
    {
        "name": "White Sox",
        "shortName": "CHW",
        "league": "American",
        "division": "Central",
        "color1": "#000000",
        "color2": "#C0C0C0"
    },
    {
        "name": "Royals",
        "shortName": "KCR",
        "league": "American",
        "division": "Central",
        "color1": "#15317E",
        "color2": "#74B4FA"
    },
    {
        "name": "Twins",
        "shortName": "MIN",
        "league": "American",
        "division": "Central",
        "color1": "#072754",
        "color2": "#C6011F"
    },
    {
        "name": "Indians",
        "shortName": "CLE",
        "league": "American",
        "division": "Central",
        "color1": "#003366",
        "color2": "#C80810"
    },
    {
        "name": "Yankees",
        "shortName": "NYY",
        "league": "American",
        "division": "East",
        "color1": "#1C2841",
        "color2": "#FFFFFF"
    },
    {
        "name": "Orioles",
        "shortName": "BAL",
        "league": "American",
        "division": "East",
        "color1": "#FB4F14",
        "color2": "black"
    },
    {
        "name": "Red Sox",
        "shortName": "BOS",
        "league": "American",
        "division": "East",
        "color1": "#C60C30",
        "color2": "#002244"
    },
    {
        "name": "Blue Jays",
        "shortName": "TOR",
        "league": "American",
        "division": "East",
        "color1": "#003DA5",
        "color2": "#041E42"
    },
    {
        "name": "Rays",
        "shortName": "TBR",
        "league": "American",
        "division": "East",
        "color1": "#00285D",
        "color2": "#9ECEEE"
    }
];

// sort team names alphabetically
teams.sort(function(a, b) {
    return a.name.toUpperCase() > b.name.toUpperCase();
});
