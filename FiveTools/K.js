// putting a bunch of global variables in here...

// constants
var K = {
    Tools: ["contact", "power", "fielding", "throwing", "speed"],
    ToolIndex: {
        contact: 0,
        power: 1,
        fielding: 2,
        throwing: 3,
        speed: 4
    },
    ToolColors: ["yellow","blue","green","red","navy"],
    ToolBounds: {
        contact:  [0.000, 0.500], // based on batting average for now ( H / AB )
        power:    [0.000, 0.700], // based on slugging ( TB / AB )
        fielding: [0.950, 1.000], // based on fielding percentage
        throwing: [10.00,  0.00], // based on ERA ( ER / IP * 9 ) (this should actually go backwards...)
        speed:    [0.5, 1.000]  // steal rate ( SB / (SB + CS) )
    },
    Teams:
        ["NYY","BAL","TBR","TOR","BOS",
        "DET","CHW","KCR","CLE","MIN",
        "OAK","TEX","LAA","SEA","HOU",
        "WSH","ATL","PHI","NYM","MIA",
        "CIN","STL","MIL","PIT","CHC",
        "SFG","LAD","ARI","SDP","COL"],
    nCols: 5,

    AngleOffset: -2 * Math.PI / 10,
    ArcTheta: 2 * Math.PI / 5,
    MinRadius: 0.0,
    Geometry: {
        width: 100,
        height: 100
    }
};
