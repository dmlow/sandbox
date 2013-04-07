/**
 * Created with JetBrains WebStorm.
 * User: fireplacetv
 * Date: 4/7/13
 * Time: 2:52 AM
 * To change this template use File | Settings | File Templates.
 */

// create a table with a cell for each team
var teamsTable = $('<table></table>');
var tRow = $('<tr></tr>');
$.each(K.Teams, function(i) {
    if(!(i% K.nCols)) { // new row every K.nCols columns
        tRow = $('<tr>');
    }
    var tCell = $('<td>')
        .attr("id", K.Teams[i])
        .addClass("teamcell")
        .append($("<h2></h2>") // add a label to the cell
            .text(K.Teams[i])
        );
    teamsTable.append(tRow.append(tCell));
});
$("body").append($("div").attr("id","toolchartsdiv")).append(teamsTable);

// draw the tools chart for each team
d3.csv("FanGraphs_2012.csv", function(error, data) {

    // specify which values we want to use for the tools
    data.forEach( function(d) {
//        d.contact = +d["AVG"];
        d.contact = +d["Contact%"];
//        d.power = +d["SLG"];
        d.power = +d["ISO"];
//        d.power = +d["LD%"] + +d["FB%"];
        d.fielding = +d["UZR/150"];
//        d.throwing = +d["ERA"];
        d.throwing = +d["PitchingWAR"];
//        d.throwing = d3.max(data, function(d) {return +d["xFIP"];}) - +d["xFIP"];
//        d.throwing = d3.max(data, function(d) {return +d["ERA"];}) - +d["ERA"];
//        d.speed = +d["SB"] / (+d["SB"] / +d["CS"]);
        d.speed = +d["Spd"];
    });

    // modify the tool bounds (yeah yeah yeah, K was supposed to be constants...)
    K.ToolBounds = {
        contact:  [d3.min(data, function(d) {return d.contact;}),  d3.max(data, function(d) {return d.contact;})],
        power:    [d3.min(data, function(d) {return d.power;}),    d3.max(data, function(d) {return d.power;})],
        fielding: [d3.min(data, function(d) {return d.fielding;}), d3.max(data, function(d) {return d.fielding;})],
        throwing: [d3.min(data, function(d) {return d.throwing;}), d3.max(data, function(d) {return d.throwing;})],
        speed:    [d3.min(data, function(d) {return d.speed;}),    d3.max(data, function(d) {return d.speed;})]
    }

    // draw the charts
    data.forEach( function(d) {
        DrawToolsChart(d["Team"],
            K.Geometry,
            {
                contact:  +d.contact,
                power:    +d.power,
                fielding: +d.fielding,
                throwing: +d.throwing,
                speed:    +d.speed
            })
    });
});
