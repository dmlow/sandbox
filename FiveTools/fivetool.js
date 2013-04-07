// these are the mins/maxes for each tool
var kTools = ["contact", "power", "fielding", "throwing", "speed"];
var kToolIndex = {
    contact: 0,
    power: 1,
    fielding: 2,
    throwing: 3,
    speed: 4
};
var kToolColors = ["yellow","blue","green","red","navy"];
var kAngleOffset = -2 * Math.PI / 10;
var kArcTheta = 2 * Math.PI / 5;
var kToolBounds = {
    contact:  [0.0, 1.000], // based on batting average for now ( H / AB )
    power:    [0.0, 4.000], // based on slugging ( TB / AB )
    fielding: [0.0, 1.000], // based on fielding percentage
    throwing: [0.0, 10.00], // based on ERA ( ER / IP * 9 ) (this should actually go backwards...)
    speed:    [0.0, 1.000]  // steal rate ( SB / (SB + CS) )
};


function NormalizedToolObject(tool, toolValues, radius) {
    return {
        color: kToolColors[kToolIndex[tool]],
        theta: kToolIndex[tool] * kArcTheta + kAngleOffset,
        value: radius * toolValues[tool] / kToolBounds[tool][1]
    };
}

function FormattedToolData(toolValues, radius) {
    return [
        NormalizedToolObject("contact", toolValues, radius),
        NormalizedToolObject("power", toolValues, radius),
        NormalizedToolObject("fielding", toolValues, radius),
        NormalizedToolObject("throwing", toolValues, radius),
        NormalizedToolObject("speed", toolValues, radius)
    ];
}

function DrawToolsChart(where, geometry, tools) {
    var radius = Math.min(geometry.width, geometry.height) / 2.0;
    var toolData = FormattedToolData(tools, radius);
    var center = {
        x: geometry.width / 2,
        y: geometry.height / 2};

    var arc = d3.svg.arc()
        .innerRadius(0)
        .outerRadius(radius);

    var pie = d3.layout.pie()
        .sort(null)
        .value(function(d) {return d;});

    var svg = d3.select('#' + where)
        .append("svg")
        .attr("width", geometry.width)
        .attr("height", geometry.height)
        .append("g")
        .attr("transform", "rotate(" + -360/5/2 + "," + center.x + "," + center.y + ")")
        .attr("transform", "translate(" + center.x + "," + center.y + ")");

    svg.selectAll(".arc")
        .data(toolData)
        .enter().append("path")
        .attr("d", d3.svg.arc()
            .innerRadius(0)
            .outerRadius(function(d) {return d.value;})
            .startAngle(function(d) {return d.theta;})
            .endAngle(function(d) {return d.theta + kArcTheta;}))
        .attr("fill", function(d) {return d.color;})
        .attr("stroke","white");
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
                    speed:    0.80
                });

