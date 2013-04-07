// these are the mins/maxes for each tool
var kToolsColors = ["blue", "red", "green", "yellow", "orange"];

kToolBounds = {
    contact:  [0.0, 1.000], // based on batting average for now ( H / AB )
    power:    [0.0, 4.000], // based on slugging ( TB / AB )
    fielding: [0.0, 1.000], // based on fielding percentage
    throwing: [0.0, 10.00], // based on ERA ( ER / IP * 9 ) (this should actually go backwards...)
    running:  [0.0, 1.000]  // steal rate ( SB / (SB + CS) )
}

function NormalizedToolValues(tools, radius) {
    // normalizes the five tools according to the bounds defined in kToolBounds and the specified radius.
    var normalizedTools = [
        radius * tools.contact  / kToolBounds["contact"][1],
        radius * tools.power    / kToolBounds["power"][1],
        radius * tools.fielding / kToolBounds["fielding"][1],
        radius * tools.throwing / kToolBounds["throwing"][1],
        radius * tools.running  / kToolBounds["running"][1]
    ];

    return normalizedTools;
}

function DrawToolsChart(where, geometry, tools) {
    var toolValues = NormalizedToolValues(tools);
    var radius = Math.min(geometry.width, geometry.height) / 2.0;
    var center = {
        x: geometry.width / 2,
        y: geometry.height / 2};

    var svg = d3.select('#' + where)
        .append("svg")
        .attr("width", geometry.width)
        .attr("height", geometry.height)
        .append("g")
        .attr("transform", "rotate(" + -360/5/2 + "," + center.x + "," + center.y + ") " +
            "translate(" + center.x + "," + center.y + ")");

    var arc = d3.svg.arc()
        .innerRadius(10)
        .outerRadius(radius);

    var pie = d3.layout.pie()
        .sort(null)
        .value(function(d) {return d});

    var g = svg.selectAll(".arc")
        .data(pie([1,1,1,1,1]))
        .enter().append("g")
        .attr("class", "arc");

    g.append("path")
        .attr("d", arc)
        .style("fill", "#ff0000");

}

DrawToolsChart("toolschart",
                {
                    width:  360,
                    height: 360
                },
                {
                    contact:  0.300,
                    power:    0.500,
                    fielding: 0.970,
                    throwing: 2.30,
                    running:  0.80
                });

