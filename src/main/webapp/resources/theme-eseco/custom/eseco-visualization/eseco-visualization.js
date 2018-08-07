/**
 * E-SECO VISUALIZATION JS
 */

/*********************************************/
/* PIE CHART                                 */
/*********************************************/
function drawPie(data, target, width) {
    // Call function to draw the Radar chart
    if (data.constructor === Object || data.constructor === Array) {
        PieChart.draw(data, target, width);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            PieChart.draw(data, target, width);
        });
    }
}

var PieChart = {
    draw: function (data, target, width) {

        if (!window.d3) {
            var d3 = d3version4;
        }

        const height = "250";

        const container = d3.select(target).html("");
        const svg = container.append("svg")
                .attr("width", width)
                .attr("height", height);

        const pieValue = d => d.quantity;
        const colorValue = d => d.rating;
        const margin = {left: 20, right: 400, top: 1, bottom: 1};

        const pie = d3.pie().value(pieValue);
        const arc = d3.arc()
                .innerRadius(40)
                .outerRadius(80);

        const g = svg.append('g')
                .attr('transform', "translate(100,90)");
        const pieG = g.append('g')
                .attr('transform', "translate(0,0)");
        const colorLegendG = g.append('g')
                .attr('transform', "translate(-50, 110)");

        const colorScale = d3.scaleOrdinal()
                .range(d3.schemeCategory10);

        const colorLegend = d3.legendColor()
                .scale(colorScale)
                .shape('circle')
                .labelOffset(10)
                .shapePadding(70)
                .orient('horizontal');

        const row = d => {
            d.population = +d.population;
            return d;
        };

        colorScale.domain(data.map(colorValue));

        const arcs = pie(data);

        pieG.selectAll('path').data(arcs)
                .enter().append('path')
                .attr('d', arc)
                .attr('fill', d => colorScale(colorValue(d.data)));

        colorLegendG.call(colorLegend)
                .selectAll('.cell text')
                .attr('dy', '0.1em');
    }
};


/*********************************************/
/* GRAPH                                     */
/*********************************************/
function drawGraph(data, target, width) {
    // Call function to draw the Radar chart
    if (data.constructor === Object) {
        GraphChart.draw(data, target, width);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            GraphChart.draw(data, target, width);
        });
    }
}

var GraphChart = {
    draw: function (data, target, width) {

        var d3 = d3version3;

        // get the data
        var nodes = data.nodes;

        // Compute the distinct nodes from the links.
        var links = data.links;

        var height = 400;

        var force = d3.layout.force()
                .nodes(data.nodes)
                .links(links)
                .size([width, height])
                .linkDistance(function (d) {
                    return 1 / d.value * 200;
                })

                .charge(-500)
                .on("tick", tick)
                .start();

        // Set the range
        var v = d3.scale.linear().range([0, 100]);

        // Scale the range of the data
        v.domain([0, d3.max(links, function (d) {
                return d.value;
            })]);

        // asign a type per value to encode opacity
        links.forEach(function (link) {
            if (v(link.value) <= 25) {
                link.type = "twofive";
            } else if (v(link.value) <= 50 && v(link.value) > 25) {
                link.type = "fivezero";
            } else if (v(link.value) <= 75 && v(link.value) > 50) {
                link.type = "sevenfive";
            } else if (v(link.value) <= 100 && v(link.value) > 75) {
                link.type = "onezerozero";
            }
        });


        var container = d3.select(target).html("");

        var svg = container.append("svg")
                .attr("width", width)
                .attr("height", height);

        // build the arrow.
        svg.append("svg:defs").selectAll("marker")
                .data(["end"])      // Different link/path types can be defined here
                .enter().append("svg:marker")    // This section adds in the arrows
                .attr("id", String)
                .attr("viewBox", "0 -5 10 10")
                .attr("refX", 30)
                .attr("refY", -1.5)
                .attr("markerWidth", 6)
                .attr("markerHeight", 6)
                .attr("orient", "auto")
                .append("svg:path")
                .attr("d", "M0,-5L10,0L0,5");


        // add the links and the arrows
        var path = svg.append("svg:g").selectAll("path")
                .data(force.links())
                .enter().append("svg:path")
                .attr("class", function (d) {
                    var classes = "link " + d.type;
                    if (d.way == "interoperate") {
                        classes += " interoperate ";
                    }
                    return classes;
                })
                .attr("marker-end", "url(#end)")
                .attr("id", function (d) {
                    return d.source.name + "_" + d.target.name + "_" + d.name;
                });

        // add link labels
        svg.selectAll(".link-label")
                .data(data.links)
                .enter().append('svg:text')
                .append("svg:textPath")
                .attr({
                    "class": "link-label",
                    "text-anchor": "middle"
                })
                .attr("xlink:href", function (d) {
                    return "#" + d.source.name + "_" + d.target.name + "_" + d.name;
                })
                .style("text-anchor", "middle")
                .attr("startOffset", "50%")
                .text(function (d) {
                    return d.name;
                });

        // define the nodes
        var node = svg.selectAll(".node")
                .data(force.nodes())
                .enter().append("g")
                .attr("class", "node")
                .call(force.drag);


        svg.append("svg:clipPath")
                .attr("id", "clip")
                .append("svg:circle")
                .attr('cx', 0)
                .attr('cy', 0)
                .attr('r', 16);

        svg.append("svg:clipPath")
                .attr("id", "clipG")
                .append("svg:circle")
                .attr('cx', 0)
                .attr('cy', 0)
                .attr('r', 32);

        // add the nodes
        node.append("circle")
                .attr("r", 16)
                .style("fill", function (d) {
                    if (d.kind == 1) {
                        return "black";
                    } else if (d.kind == 2) {
                        return "red";
                    } else if (d.kind == 3) {
                        return "green";
                    } else if (d.kind == 4) {
                        return "blue";
                    } else if (d.kind == 5) {
                        return "purple";
                    } else if (d.kind == 6) {
                        return "yellow";
                    } else if (d.kind == 7) {
                        return "gray";
                    } else if (d.kind == 8) {
                        return "red";
                    } else if (d.kind == 9) {
                        return "green";
                    } else if (d.kind == 10) {
                        return "blue";
                    } else if (d.kind == 11) {
                        return "purple";
                    } else if (d.kind == 12) {
                        return "yellow";
                    } else if (d.kind == 13) {
                        return "gray";
                    }
                });


        //add images at the nodes
        var images = node.append("svg:image")
                .attr("xlink:href", function (d) {
                    return d.img;
                })
                .attr("x", "-16px")
                .attr("y", "-16px")
                .attr("width", "32px")
                .attr("height", "32px")
                .attr("clip-path", "url(#clip)");

        images.on('mouseenter', function () {
            // select element in current context
            d3.select(this)
                    .transition()
                    .attr("x", function (d) {
                        return -32;
                    })
                    .attr("y", function (d) {
                        return -32;
                    })
                    .attr("height", 64)
                    .attr("width", 64)
                    .attr("clip-path", "url(#clipG)");
        }).on('mouseleave', function () {
            d3.select(this)
                    .transition()
                    .attr("x", function (d) {
                        return -16;
                    })
                    .attr("y", function (d) {
                        return -16;
                    })
                    .attr("height", 32)
                    .attr("width", 32)
                    .attr("clip-path", "url(#clip)");
        });


        // add the text
        node.append("text")
                .attr("x", 15)
                .attr("dy", ".35em")
                .text(function (d) {
                    if (d.label == "false") {
                        return "";
                    }
                    return d.name.split('.').pop();
                });




        // add tooltip information
        var tip;
        node.on("dblclick", function (d) {
            if (tip)
                tip.remove();

            tip = svg.append("g")
                    .attr("transform", "translate(" + d.x + "," + d.y + ")");

            var rect = tip.append("rect")
                    .style("fill", "white")
                    .style("stroke", "steelblue");

            tip.append("text")
                    .text(d.name)
                    .attr("dy", "1em")
                    .attr("x", 5);



            if (d.info) {
                tip.append("text")
                        .text("Details: ")
                        .attr("dy", "2em")
                        .attr("x", 5);
                for (var i = 0; i < d.info.split('\n').length; i++) {
                    var pos = 3 + i;
                    pos = pos + "em";
                    tip.append("text")
                            .text(d.info.split('\n')[i])
                            .attr("dy", pos)
                            .attr("x", 5);
                }
            }

            var bbox = tip.node().getBBox();
            rect.attr("width", bbox.width + 5)
                    .attr("height", bbox.height + 5);
        });

        container.on("click", function (d) {
            if (tip)
                tip.remove();
        });


        // add the curvy lines
        function tick() {

            path.attr("d", function (d) {
                var dx = d.target.x - d.source.x,
                        dy = d.target.y - d.source.y,
                        dr = Math.sqrt(dx * dx + dy * dy);

                if (isNaN(d.linknum) || d.linknum == null || d.linknum == undefined || d.linknum == 1) {
                    d.linknum = 1;
                    //rx ry x-axis-rotation large-arc-flag sweep-flag x y
                    return "M" +
                            d.source.x + "," +
                            d.source.y + "A" +
                            dr + "," + dr + " 0 0,1 " +
                            d.target.x + "," +
                            d.target.y;
                } else {
                    //rx ry x-axis-rotation large-arc-flag sweep-flag x y
                    return "M" +
                            d.source.x + "," +
                            d.source.y + "A" +
                            dr + "," + dr + " 0 0,0 " +
                            d.target.x + "," +
                            d.target.y;
                }
            });

            node.attr("transform", function (d) {
                return "translate(" + d.x + "," + d.y + ")";
            });
        }

    }
};


/*********************************************/
/* TREEMAP                                   */
/*********************************************/
function drawTreemap(datFn01, target, width) {

    // Call function to draw the chart
    if (datFn01.constructor === Object) {
        TreemapChart.draw(datFn01, target, width);

    } else if (typeof datFn01 === "string") {
        d3.json(datFn01, function (error, data) {
            if (error)
                throw error;
            TreemapChart.draw(data, target, width);
        });
    }
}

function hovered(hover) {
    return function (d) {
        if (!window.d3) {
            var d3 = d3version4;
        }
        d3.selectAll(d.ancestors().map(function (d) {
            return d.node;
        }))
                .classed("node--hover", hover)
                .select("rect")
                .attr("width", function (d) {
                    return d.x1 - d.x0 - hover;
                })
                .attr("height", function (d) {
                    return d.y1 - d.y0 - hover;
                });
    };
}

var TreemapChart = {
    draw: function (data, target, width) {
        if (!window.d3) {
            var d3 = d3version4;
        }

        var paddingAllowance = 2;

        var container = d3.select(target).html("");

        var svg = container.append("svg");
        var width = width;
        var height = 250;


        svg.attr("width", width).attr("height", height);

        var color = d3.scaleOrdinal(d3.schemeCategory20c);

        var treemap = d3.treemap()
                .size([width, height])
                .paddingOuter(3)
                .paddingTop(19)
                .paddingInner(1)
                .round(true);


        var root = d3.hierarchy(data)
                .eachBefore(function (d) {
                    d.data.id = (d.parent ? d.parent.data.id + "." : "") + d.data.name;
                })
                .sum(function (d) {
                    return d.size;
                })
                .sort(function (a, b) {
                    return b.height - a.height || b.value - a.value;
                });

        var node = root;
        treemap(root);


        var cell = svg
                .selectAll(".node")
                .data(root.descendants())
                .enter().append("g")
                .attr("transform", function (d) {
                    return "translate(" + d.x0 + "," + d.y0 + ")";
                })
                .attr("class", "node")
                .each(function (d) {
                    d.node = this;
                })
                .on("mouseover", hovered(true))
                .on("mouseout", hovered(false));

        cell.append("rect")
                .attr("id", function (d) {
                    return "rect-" + d.id;
                })
                .attr("width", function (d) {
                    return d.x1 - d.x0;
                })
                .attr("height", function (d) {
                    return d.y1 - d.y0;
                })
                .style("fill", function (d) {
                    return color(d.depth);
                });

        cell.append("foreignObject")
                .attr("class", "foreignObject")
                .attr("width", function (d) {
                    return d.x1 - d.x0 - paddingAllowance;
                })
                .attr("height", function (d) {
                    return d.y1 - d.y0 - paddingAllowance;
                })
                .append("xhtml:div")
                .attr("class", "treemap-block-header")
                .append("p")
                .text(function (d) {
                    return d.data.name;
                })
                .attr("text-anchor", "middle")
    }
};


/*********************************************/
/* RADAR                                     */
/*********************************************/
function drawRadar(data, targetId, maxValue) {
    /*
     var svg = d3.select("svg");
     svg.html("");
     */

    var width = 300,
            height = 300;

    // Config for the Radar chart
    var config = {
        w: width,
        h: height,
        maxValue: maxValue > 0 ? maxValue : 1,
        levels: 10,
        ExtraWidthX: 300
    };

    // Call function to draw the Radar chart
    if (data.constructor === Array) {
        RadarChart.draw("#" + targetId, data, config);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            RadarChart.draw("#" + targetId, data, config);
        });
    }

    var svg = d3.select('body')
            .selectAll('svg')
            .append('svg')
            .attr("width", width)
            .attr("height", height);
}

var RadarChart = {
    draw: function (id, d, options) {
        var cfg = {
            radius: 5,
            w: 600,
            h: 600,
            factor: 1,
            factorLegend: .85,
            levels: 3,
            maxValue: 0,
            radians: 2 * Math.PI,
            opacityArea: 0.5,
            ToRight: 5,
            TranslateX: 80,
            TranslateY: 30,
            ExtraWidthX: 100,
            ExtraWidthY: 100,
            color: d3.scaleOrdinal(d3.schemeCategory10)
        };

        if ('undefined' !== typeof options) {
            for (var i in options) {
                if ('undefined' !== typeof options[i]) {
                    cfg[i] = options[i];
                }
            }
        }


        var allAxis = (d[0].map(function (i, j) {
            return i.area
        }));
        var total = allAxis.length;
        var radius = cfg.factor * Math.min(cfg.w / 2, cfg.h / 2);
        var Format = d3.format('%');
        d3.select(id).select("svg").remove();


        var container = d3.select(id).html("");

        var g = container
                .append("svg")
                .attr("width", cfg.w + cfg.ExtraWidthX)
                .attr("height", cfg.h + cfg.ExtraWidthY)
                .append("g")
                .attr("transform", "translate(" + cfg.TranslateX + "," + cfg.TranslateY + ")");

        var tooltip;

        //Circular segments
        for (var j = 0; j < cfg.levels; j++) {
            var levelFactor = cfg.factor * radius * ((j + 1) / cfg.levels);
            g.selectAll(".levels")
                    .data(allAxis)
                    .enter()
                    .append("svg:line")
                    .attr("x1", function (d, i) {
                        return levelFactor * (1 - cfg.factor * Math.sin(i * cfg.radians / total));
                    })
                    .attr("y1", function (d, i) {
                        return levelFactor * (1 - cfg.factor * Math.cos(i * cfg.radians / total));
                    })
                    .attr("x2", function (d, i) {
                        return levelFactor * (1 - cfg.factor * Math.sin((i + 1) * cfg.radians / total));
                    })
                    .attr("y2", function (d, i) {
                        return levelFactor * (1 - cfg.factor * Math.cos((i + 1) * cfg.radians / total));
                    })
                    .attr("class", "line")
                    .style("stroke", "grey")
                    .style("stroke-opacity", "0.75")
                    .style("stroke-width", "0.3px")
                    .attr("transform", "translate(" + (cfg.w / 2 - levelFactor) + ", " + (cfg.h / 2 - levelFactor) + ")");
        }

        //Text indicating at what % each level is
        for (var j = 0; j < cfg.levels; j++) {
            var levelFactor = cfg.factor * radius * ((j + 1) / cfg.levels);
            g.selectAll(".levels")
                    .data([1]) //dummy data
                    .enter()
                    .append("svg:text")
                    .attr("x", function (d) {
                        return levelFactor * (1 - cfg.factor * Math.sin(0));
                    })
                    .attr("y", function (d) {
                        return levelFactor * (1 - cfg.factor * Math.cos(0));
                    })
                    .attr("class", "legend")
                    .style("font-family", "sans-serif")
                    .style("font-size", "10px")
                    .attr("transform", "translate(" + (cfg.w / 2 - levelFactor + cfg.ToRight) + ", " + (cfg.h / 2 - levelFactor) + ")")
                    .attr("fill", "#737373")
                    .text((j + 1) * cfg.maxValue / cfg.levels);
        }

        series = 0;

        var axis = g.selectAll(".axis")
                .data(allAxis)
                .enter()
                .append("g")
                .attr("class", "axis");

        axis.append("line")
                .attr("x1", cfg.w / 2)
                .attr("y1", cfg.h / 2)
                .attr("x2", function (d, i) {
                    return cfg.w / 2 * (1 - cfg.factor * Math.sin(i * cfg.radians / total));
                })
                .attr("y2", function (d, i) {
                    return cfg.h / 2 * (1 - cfg.factor * Math.cos(i * cfg.radians / total));
                })
                .attr("class", "line")
                .style("stroke", "grey")
                .style("stroke-width", "1px");

        axis.append("text")
                .attr("class", "legend")
                .text(function (d) {
                    return d
                })
                .style("font-family", "sans-serif")
                .style("font-size", "11px")
                .attr("text-anchor", "middle")
                .attr("dy", "1.5em")
                .attr("transform", function (d, i) {
                    return "translate(0, -10)"
                })
                .attr("x", function (d, i) {
                    return cfg.w / 2 * (1 - cfg.factorLegend * Math.sin(i * cfg.radians / total)) - 60 * Math.sin(i * cfg.radians / total);
                })
                .attr("y", function (d, i) {
                    return cfg.h / 2 * (1 - Math.cos(i * cfg.radians / total)) - 20 * Math.cos(i * cfg.radians / total);
                });


        d.forEach(function (y, x) {
            dataValues = [];
            g.selectAll(".nodes")
                    .data(y, function (j, i) {
                        dataValues.push([
                            cfg.w / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.sin(i * cfg.radians / total)),
                            cfg.h / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.cos(i * cfg.radians / total))
                        ]);
                    });
            dataValues.push(dataValues[0]);
            g.selectAll(".area")
                    .data([dataValues])
                    .enter()
                    .append("polygon")
                    .attr("class", "radar-chart-serie" + series)
                    .style("stroke-width", "2px")
                    .style("stroke", cfg.color(series))
                    .attr("points", function (d) {
                        var str = "";
                        for (var pti = 0; pti < d.length; pti++) {
                            str = str + d[pti][0] + "," + d[pti][1] + " ";
                        }
                        return str;
                    })
                    .style("fill", function (j, i) {
                        return cfg.color(series)
                    })
                    .style("fill-opacity", cfg.opacityArea)
                    .on('mouseover', function (d) {
                        z = "polygon." + d3.select(this).attr("class");
                        g.selectAll("polygon")
                                .transition(200)
                                .style("fill-opacity", 0.1);
                        g.selectAll(z)
                                .transition(200)
                                .style("fill-opacity", .7);
                    })
                    .on('mouseout', function () {
                        g.selectAll("polygon")
                                .transition(200)
                                .style("fill-opacity", cfg.opacityArea);
                    });
            series++;
        });
        series = 0;


        var tooltip = d3.select("body").append("div").attr("class", "toolTip");
        d.forEach(function (y, x) {
            g.selectAll(".nodes")
                    .data(y).enter()
                    .append("svg:circle")
                    .attr("class", "radar-chart-serie" + series)
                    .attr('r', cfg.radius)
                    .attr("alt", function (j) {
                        return Math.max(j.value, 0)
                    })
                    .attr("cx", function (j, i) {
                        dataValues.push([
                            cfg.w / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.sin(i * cfg.radians / total)),
                            cfg.h / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.cos(i * cfg.radians / total))
                        ]);
                        return cfg.w / 2 * (1 - (Math.max(j.value, 0) / cfg.maxValue) * cfg.factor * Math.sin(i * cfg.radians / total));
                    })
                    .attr("cy", function (j, i) {
                        return cfg.h / 2 * (1 - (Math.max(j.value, 0) / cfg.maxValue) * cfg.factor * Math.cos(i * cfg.radians / total));
                    })
                    .attr("data-id", function (j) {
                        return j.area
                    })
                    .style("fill", "#fff")
                    .style("stroke-width", "2px")
                    .style("stroke", cfg.color(series)).style("fill-opacity", .9)
                    .on('mouseover', function (d) {
                        tooltip
                                .style("left", d3.event.pageX - 40 + "px")
                                .style("top", d3.event.pageY - 80 + "px")
                                .style("display", "inline-block")
                                .html((d.area) + "<br><span>" + (d.value) + "</span>");
                    })
                    .on("mouseout", function (d) {
                        tooltip.style("display", "none");
                    });

            series++;
        });
    }
};


/*********************************************/
/* PARALLEL COORDINATES                      */
/*********************************************/
function drawParallelCoordinates(data, targetId) {
    var width = 800,
            height = 500;

    var options = {};

    // Call function to draw the Radar chart
    if (data.constructor === Array) {
        ParallelCoordinatesChart.draw(data, targetId, options);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            ParallelCoordinatesChart.draw(data, targetId, options);
        });
    }

    var svg = d3.select('body')
            .selectAll('svg')
            .append('svg')
            .attr("width", width)
            .attr("height", height);
}

var ParallelCoordinatesChart = {
    draw: function (data, targetId, options) {
        var margin = {top: 50, right: 160, bottom: 20, left: 120},
                width = 1000,
                height = 340;

        var devicePixelRatio = window.devicePixelRatio || 1;

        var color = d3.scale.ordinal()
                .range(["#5DA5B3", "#D58323", "#DD6CA7", "#54AF52", "#8C92E8", "#E15E5A", "#725D82", "#776327", "#50AB84", "#954D56", "#AB9C27", "#517C3F", "#9D5130", "#357468", "#5E9ACF", "#C47DCB", "#7D9E33", "#DB7F85", "#BA89AD", "#4C6C86", "#B59248", "#D8597D", "#944F7E", "#D67D4B", "#8F86C2"]);

        var types = {
            "Number": {
                key: "Number",
                coerce: function (d) {
                    return +d;
                },
                extent: d3.extent,
                within: function (d, extent) {
                    return extent[0] <= d && d <= extent[1];
                },
                defaultScale: d3.scale.linear().range([height, 0])
            },
            "String": {
                key: "String",
                coerce: String,
                extent: function (data) {
                    return data.sort();
                },
                within: function (d, extent, dim) {
                    return extent[0] <= dim.scale(d) && dim.scale(d) <= extent[1];
                },
                defaultScale: d3.scale.ordinal().rangePoints([0, height])
            },
            "Date": {
                key: "Date",
                coerce: function (d) {
                    return new Date(d);
                },
                extent: d3.extent,
                within: function (d, extent) {
                    return extent[0] <= d && d <= extent[1];
                },
                defaultScale: d3.time.scale().range([0, height])
            }
        };

        var dimensions = [
            {
                key: "developer",
                description: "Developer",
                type: types["String"],
                axis: d3.svg.axis().orient("left")
            }, {
                key: "date",
                description: "Date",
                type: types["String"],
                axis: d3.svg.axis().orient("left")
            }, {
                key: "documentation",
                description: "Documentation",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "ease_of_use",
                description: "Ease of Use",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "reliability",
                description: "Reliability",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "performance",
                description: "Performance",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "availability",
                description: "Availability",
                type: types["Number"],
                domain: [0, 10]
            }
        ];

        var xscale = d3.scale.ordinal()
                .domain(d3.range(dimensions.length))
                .rangePoints([0, width]);

        var yAxis = d3.svg.axis()
                .orient("left");

        var container = d3.select("#" + targetId).append("div")
                .attr("class", "parcoords")
                .style("width", width + margin.left + margin.right + "px")
                .style("height", height + margin.top + margin.bottom + "px");

        var svg = container.append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        var canvas = container.append("canvas")
                .attr("width", (width + 1) * devicePixelRatio)
                .attr("height", (height + 1) * devicePixelRatio)
                .style("width", (width + 1) + "px")
                .style("height", (height + 1) + "px")
                .style("margin-top", margin.top + "px")
                .style("margin-left", margin.left + "px");

        var ctx = canvas.node().getContext("2d");
        ctx.globalCompositeOperation = 'darken';
        ctx.globalAlpha = 0.15;
        ctx.lineWidth = 1.5;
        ctx.scale(devicePixelRatio, devicePixelRatio);

        var axes = svg.selectAll(".axis")
                .data(dimensions)
                .enter().append("g")
                .attr("class", function (d) {
                    return "axis " + d.key;
                })
                .attr("transform", function (d, i) {
                    return "translate(" + xscale(i) + ")";
                });


        // type/dimension default setting happens here
        dimensions.forEach(function (dim) {
            if (!("domain" in dim)) {
                // detect domain using dimension type's extent function
                dim.domain = d3.functor(dim.type.extent)(data.map(function (d) {
                    return d[dim.key];
                }));

                // TODO - this line only works because the data encodes data with integers
                // Sorting/comparing should be defined at the type/dimension level
                dim.domain.sort(function (a, b) {
                    return a - b;
                });
            }
            if (!("scale" in dim)) {
                // use type's default scale for dimension
                dim.scale = dim.type.defaultScale.copy();
            }
            dim.scale.domain(dim.domain);
        });

        var render = renderQueue(draw).rate(30);

        ctx.clearRect(0, 0, width + 1, height + 1);
        ctx.globalAlpha = d3.min([0.75 / Math.pow(data.length, 0.3), 1]);
        render(data);

        axes.append("g")
                .each(function (d) {
                    var renderAxis = "axis" in d
                            ? d.axis.scale(d.scale)  // custom axis
                            : yAxis.scale(d.scale);  // default axis
                    d3.select(this).call(renderAxis);
                })
                .append("text")
                .attr("class", "title")
                .attr("text-anchor", "start")
                .text(function (d) {
                    return "description" in d ? d.description : d.key;
                });

        // Add and store a brush for each axis.
        axes.append("g")
                .attr("class", "brush")
                .each(function (d) {
                    d3.select(this).call(d.brush = d3.svg.brush()
                            .y(d.scale)
                            .on("brushstart", brushstart)
                            .on("brush", brush));
                })
                .selectAll("rect")
                .attr("x", -8)
                .attr("width", 16);

        d3.selectAll(".axis.food_group .tick text")
                .style("fill", color);


        function project(d) {
            return dimensions.map(function (p, i) {
                if (d[p.key] === null)
                    return null;
                return [xscale(i), p.scale(d[p.key])];
            });
        }
        ;

        function draw(d) {
            ctx.strokeStyle = color(d.food_group);
            ctx.beginPath();
            var coords = project(d);
            coords.forEach(function (p, i) {
                // this tricky bit avoids rendering null values as 0
                if (p === null) {
                    // this bit renders horizontal lines on the previous/next
                    // dimensions, so that sandwiched null values are visible
                    if (i > 0) {
                        var prev = coords[i - 1];
                        if (prev !== null) {
                            ctx.moveTo(prev[0], prev[1]);
                            ctx.lineTo(prev[0] + 6, prev[1]);
                        }
                    }
                    if (i < coords.length - 1) {
                        var next = coords[i + 1];
                        if (next !== null) {
                            ctx.moveTo(next[0] - 6, next[1]);
                        }
                    }
                    return;
                }

                if (i == 0) {
                    ctx.moveTo(p[0], p[1]);
                    return;
                }

                ctx.lineTo(p[0], p[1]);
            });
            ctx.stroke();
        }

        function brushstart() {
            d3.event.sourceEvent.stopPropagation();
        }

        // Handles a brush event, toggling the display of foreground lines.
        function brush() {
            var actives = dimensions.filter(function (p) {
                return !p.brush.empty();
            }),
                    extents = actives.map(function (p) {
                        return p.brush.extent();
                    });

            var selected = data.filter(function (d) {
                if (actives.every(function (dim, i) {
                    // test if point is within extents for each active brush
                    return dim.type.within(d[dim.key], extents[i], dim);
                })) {
                    return true;
                }
            });

            ctx.clearRect(0, 0, width + 1, height + 1);
            ctx.globalAlpha = d3.min([0.75 / Math.pow(selected.length, 0.3), 1]);
            render(selected);
        }

    }
};

var renderQueue = (function (func) {
    var _queue = [], // data to be rendered
            _rate = 1000, // number of calls per frame
            _invalidate = function () {
            }, // invalidate last render queue
            _clear = function () {
            };       // clearing function

    var rq = function (data) {
        if (data)
            rq.data(data);
        _invalidate();
        _clear();
        rq.render();
    };

    rq.render = function () {
        var valid = true;
        _invalidate = rq.invalidate = function () {
            valid = false;
        };

        function doFrame() {
            if (!valid)
                return true;
            var chunk = _queue.splice(0, _rate);
            chunk.map(func);
            timer_frame(doFrame);
        }

        doFrame();
    };

    rq.data = function (data) {
        _invalidate();
        _queue = data.slice(0);   // creates a copy of the data
        return rq;
    };

    rq.add = function (data) {
        _queue = _queue.concat(data);
    };

    rq.rate = function (value) {
        if (!arguments.length)
            return _rate;
        _rate = value;
        return rq;
    };

    rq.remaining = function () {
        return _queue.length;
    };

    // clear the canvas
    rq.clear = function (func) {
        if (!arguments.length) {
            _clear();
            return rq;
        }
        _clear = func;
        return rq;
    };

    rq.invalidate = _invalidate;

    var timer_frame = window.requestAnimationFrame
            || window.webkitRequestAnimationFrame
            || window.mozRequestAnimationFrame
            || window.oRequestAnimationFrame
            || window.msRequestAnimationFrame
            || function (callback) {
                setTimeout(callback, 17);
            };

    return rq;
});


/*********************************************/
/* WORD COUNT                                */
/*********************************************/
function drawWordCount(data, target, width) {

    // Call function to draw the chart
    if (data.constructor === Array) {
        WordCountChart.draw(data, target, width);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            WordCountChart.draw(data, target, width);
        });
    }
}

var WordCountChart = {
    draw: function (data, target, width) {
        var color = d3.scale.linear()
                .domain([0, 1, 2, 3, 4, 5, 6, 10, 15, 20, 100])
                .range(["#ddd", "#ccc", "#bbb", "#aaa", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"]);

        d3.layout.cloud().size([(width - 50), 200])
                .words(data)
                .rotate(0)
                .fontSize(function (d) {
                    return d.size;
                })
                .on("end", draw)
                .start();

        function draw(words) {
            d3.select(target).append("svg")
                    .attr("width", width)
                    .attr("height", 250)
                    .attr("class", "wordcloud")
                    .append("g")
                    // without the transform, words words would get cutoff to the left and top, they would
                    // appear outside of the SVG area
                    .attr("transform", "translate(" + ((width - 50) / 2) + ",125)")
                    .selectAll("text")
                    .data(words)
                    .enter().append("text")
                    .style("font-size", function (d) {
                        return d.size + "px";
                    })
                    .style("fill", function (d, i) {
                        return color(i);
                    })
                    .attr("transform", function (d) {
                        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                    })
                    .text(function (d) {
                        return d.text;
                    });
        }

    }
};

// Word cloud layout by Jason Davies, http://www.jasondavies.com/word-cloud/
// Algorithm due to Jonathan Feinberg, http://static.mrfeinberg.com/bv_ch03.pdf
if (d3) {
    (function (exports) {
        function cloud() {
            var size = [256, 256],
                    text = cloudText,
                    font = cloudFont,
                    fontSize = cloudFontSize,
                    fontStyle = cloudFontNormal,
                    fontWeight = cloudFontNormal,
                    rotate = cloudRotate,
                    padding = cloudPadding,
                    spiral = archimedeanSpiral,
                    words = [],
                    timeInterval = Infinity,
                    event = d3.dispatch("word", "end"),
                    timer = null,
                    cloud = {};

            cloud.start = function () {
                var board = zeroArray((size[0] >> 5) * size[1]),
                        bounds = null,
                        n = words.length,
                        i = -1,
                        tags = [],
                        data = words.map(function (d, i) {
                            d.text = text.call(this, d, i);
                            d.font = font.call(this, d, i);
                            d.style = fontStyle.call(this, d, i);
                            d.weight = fontWeight.call(this, d, i);
                            d.rotate = rotate.call(this, d, i);
                            d.size = ~~fontSize.call(this, d, i);
                            d.padding = padding.call(this, d, i);
                            return d;
                        }).sort(function (a, b) {
                    return b.size - a.size;
                });

                if (timer)
                    clearInterval(timer);
                timer = setInterval(step, 0);
                step();

                return cloud;

                function step() {
                    var start = +new Date,
                            d;
                    while (+new Date - start < timeInterval && ++i < n && timer) {
                        d = data[i];
                        d.x = (size[0] * (Math.random() + .5)) >> 1;
                        d.y = (size[1] * (Math.random() + .5)) >> 1;
                        cloudSprite(d, data, i);
                        if (d.hasText && place(board, d, bounds)) {
                            tags.push(d);
                            event.word(d);
                            if (bounds)
                                cloudBounds(bounds, d);
                            else
                                bounds = [{x: d.x + d.x0, y: d.y + d.y0}, {x: d.x + d.x1, y: d.y + d.y1}];
                            // Temporary hack
                            d.x -= size[0] >> 1;
                            d.y -= size[1] >> 1;
                        }
                    }
                    if (i >= n) {
                        cloud.stop();
                        event.end(tags, bounds);
                    }
                }
            }

            cloud.stop = function () {
                if (timer) {
                    clearInterval(timer);
                    timer = null;
                }
                return cloud;
            };

            cloud.timeInterval = function (x) {
                if (!arguments.length)
                    return timeInterval;
                timeInterval = x == null ? Infinity : x;
                return cloud;
            };

            function place(board, tag, bounds) {
                var perimeter = [{x: 0, y: 0}, {x: size[0], y: size[1]}],
                        startX = tag.x,
                        startY = tag.y,
                        maxDelta = Math.sqrt(size[0] * size[0] + size[1] * size[1]),
                        s = spiral(size),
                        dt = Math.random() < .5 ? 1 : -1,
                        t = -dt,
                        dxdy,
                        dx,
                        dy;

                while (dxdy = s(t += dt)) {
                    dx = ~~dxdy[0];
                    dy = ~~dxdy[1];

                    if (Math.min(dx, dy) > maxDelta)
                        break;

                    tag.x = startX + dx;
                    tag.y = startY + dy;

                    if (tag.x + tag.x0 < 0 || tag.y + tag.y0 < 0 ||
                            tag.x + tag.x1 > size[0] || tag.y + tag.y1 > size[1])
                        continue;
                    // TODO only check for collisions within current bounds.
                    if (!bounds || !cloudCollide(tag, board, size[0])) {
                        if (!bounds || collideRects(tag, bounds)) {
                            var sprite = tag.sprite,
                                    w = tag.width >> 5,
                                    sw = size[0] >> 5,
                                    lx = tag.x - (w << 4),
                                    sx = lx & 0x7f,
                                    msx = 32 - sx,
                                    h = tag.y1 - tag.y0,
                                    x = (tag.y + tag.y0) * sw + (lx >> 5),
                                    last;
                            for (var j = 0; j < h; j++) {
                                last = 0;
                                for (var i = 0; i <= w; i++) {
                                    board[x + i] |= (last << msx) | (i < w ? (last = sprite[j * w + i]) >>> sx : 0);
                                }
                                x += sw;
                            }
                            delete tag.sprite;
                            return true;
                        }
                    }
                }
                return false;
            }

            cloud.words = function (x) {
                if (!arguments.length)
                    return words;
                words = x;
                return cloud;
            };

            cloud.size = function (x) {
                if (!arguments.length)
                    return size;
                size = [+x[0], +x[1]];
                return cloud;
            };

            cloud.font = function (x) {
                if (!arguments.length)
                    return font;
                font = d3.functor(x);
                return cloud;
            };

            cloud.fontStyle = function (x) {
                if (!arguments.length)
                    return fontStyle;
                fontStyle = d3.functor(x);
                return cloud;
            };

            cloud.fontWeight = function (x) {
                if (!arguments.length)
                    return fontWeight;
                fontWeight = d3.functor(x);
                return cloud;
            };

            cloud.rotate = function (x) {
                if (!arguments.length)
                    return rotate;
                rotate = d3.functor(x);
                return cloud;
            };

            cloud.text = function (x) {
                if (!arguments.length)
                    return text;
                text = d3.functor(x);
                return cloud;
            };

            cloud.spiral = function (x) {
                if (!arguments.length)
                    return spiral;
                spiral = spirals[x + ""] || x;
                return cloud;
            };

            cloud.fontSize = function (x) {
                if (!arguments.length)
                    return fontSize;
                fontSize = d3.functor(x);
                return cloud;
            };

            cloud.padding = function (x) {
                if (!arguments.length)
                    return padding;
                padding = d3.functor(x);
                return cloud;
            };

            return d3.rebind(cloud, event, "on");
        }

        function cloudText(d) {
            return d.text;
        }

        function cloudFont() {
            return "serif";
        }

        function cloudFontNormal() {
            return "normal";
        }

        function cloudFontSize(d) {
            return Math.sqrt(d.value);
        }

        function cloudRotate() {
            return (~~(Math.random() * 6) - 3) * 30;
        }

        function cloudPadding() {
            return 1;
        }

        // Fetches a monochrome sprite bitmap for the specified text.
        // Load in batches for speed.
        function cloudSprite(d, data, di) {
            if (d.sprite)
                return;
            c.clearRect(0, 0, (cw << 5) / ratio, ch / ratio);
            var x = 0,
                    y = 0,
                    maxh = 0,
                    n = data.length;
            --di;
            while (++di < n) {
                d = data[di];
                c.save();
                c.font = d.style + " " + d.weight + " " + ~~((d.size + 1) / ratio) + "px " + d.font;
                var w = c.measureText(d.text + "m").width * ratio,
                        h = d.size << 1;
                if (d.rotate) {
                    var sr = Math.sin(d.rotate * cloudRadians),
                            cr = Math.cos(d.rotate * cloudRadians),
                            wcr = w * cr,
                            wsr = w * sr,
                            hcr = h * cr,
                            hsr = h * sr;
                    w = (Math.max(Math.abs(wcr + hsr), Math.abs(wcr - hsr)) + 0x1f) >> 5 << 5;
                    h = ~~Math.max(Math.abs(wsr + hcr), Math.abs(wsr - hcr));
                } else {
                    w = (w + 0x1f) >> 5 << 5;
                }
                if (h > maxh)
                    maxh = h;
                if (x + w >= (cw << 5)) {
                    x = 0;
                    y += maxh;
                    maxh = 0;
                }
                if (y + h >= ch)
                    break;
                c.translate((x + (w >> 1)) / ratio, (y + (h >> 1)) / ratio);
                if (d.rotate)
                    c.rotate(d.rotate * cloudRadians);
                c.fillText(d.text, 0, 0);
                if (d.padding)
                    c.lineWidth = 2 * d.padding, c.strokeText(d.text, 0, 0);
                c.restore();
                d.width = w;
                d.height = h;
                d.xoff = x;
                d.yoff = y;
                d.x1 = w >> 1;
                d.y1 = h >> 1;
                d.x0 = -d.x1;
                d.y0 = -d.y1;
                d.hasText = true;
                x += w;
            }
            var pixels = c.getImageData(0, 0, (cw << 5) / ratio, ch / ratio).data,
                    sprite = [];
            while (--di >= 0) {
                d = data[di];
                if (!d.hasText)
                    continue;
                var w = d.width,
                        w32 = w >> 5,
                        h = d.y1 - d.y0;
                // Zero the buffer
                for (var i = 0; i < h * w32; i++)
                    sprite[i] = 0;
                x = d.xoff;
                if (x == null)
                    return;
                y = d.yoff;
                var seen = 0,
                        seenRow = -1;
                for (var j = 0; j < h; j++) {
                    for (var i = 0; i < w; i++) {
                        var k = w32 * j + (i >> 5),
                                m = pixels[((y + j) * (cw << 5) + (x + i)) << 2] ? 1 << (31 - (i % 32)) : 0;
                        sprite[k] |= m;
                        seen |= m;
                    }
                    if (seen)
                        seenRow = j;
                    else {
                        d.y0++;
                        h--;
                        j--;
                        y++;
                    }
                }
                d.y1 = d.y0 + seenRow;
                d.sprite = sprite.slice(0, (d.y1 - d.y0) * w32);
            }
        }

        // Use mask-based collision detection.
        function cloudCollide(tag, board, sw) {
            sw >>= 5;
            var sprite = tag.sprite,
                    w = tag.width >> 5,
                    lx = tag.x - (w << 4),
                    sx = lx & 0x7f,
                    msx = 32 - sx,
                    h = tag.y1 - tag.y0,
                    x = (tag.y + tag.y0) * sw + (lx >> 5),
                    last;
            for (var j = 0; j < h; j++) {
                last = 0;
                for (var i = 0; i <= w; i++) {
                    if (((last << msx) | (i < w ? (last = sprite[j * w + i]) >>> sx : 0))
                            & board[x + i])
                        return true;
                }
                x += sw;
            }
            return false;
        }

        function cloudBounds(bounds, d) {
            var b0 = bounds[0],
                    b1 = bounds[1];
            if (d.x + d.x0 < b0.x)
                b0.x = d.x + d.x0;
            if (d.y + d.y0 < b0.y)
                b0.y = d.y + d.y0;
            if (d.x + d.x1 > b1.x)
                b1.x = d.x + d.x1;
            if (d.y + d.y1 > b1.y)
                b1.y = d.y + d.y1;
        }

        function collideRects(a, b) {
            return a.x + a.x1 > b[0].x && a.x + a.x0 < b[1].x && a.y + a.y1 > b[0].y && a.y + a.y0 < b[1].y;
        }

        function archimedeanSpiral(size) {
            var e = size[0] / size[1];
            return function (t) {
                return [e * (t *= .1) * Math.cos(t), t * Math.sin(t)];
            };
        }

        function rectangularSpiral(size) {
            var dy = 4,
                    dx = dy * size[0] / size[1],
                    x = 0,
                    y = 0;
            return function (t) {
                var sign = t < 0 ? -1 : 1;
                // See triangular numbers: T_n = n * (n + 1) / 2.
                switch ((Math.sqrt(1 + 4 * sign * t) - sign) & 3) {
                    case 0:
                        x += dx;
                        break;
                    case 1:
                        y += dy;
                        break;
                    case 2:
                        x -= dx;
                        break;
                    default:
                        y -= dy;
                        break;
                }
                return [x, y];
            };
        }

        // TODO reuse arrays?
        function zeroArray(n) {
            var a = [],
                    i = -1;
            while (++i < n)
                a[i] = 0;
            return a;
        }

        var cloudRadians = Math.PI / 180,
                cw = 1 << 11 >> 5,
                ch = 1 << 11,
                canvas,
                ratio = 1;

        if (typeof document !== "undefined") {
            canvas = document.createElement("canvas");
            canvas.width = 1;
            canvas.height = 1;
            ratio = Math.sqrt(canvas.getContext("2d").getImageData(0, 0, 1, 1).data.length >> 2);
            canvas.width = (cw << 5) / ratio;
            canvas.height = ch / ratio;
        } else {
            // node-canvas support
            var Canvas = require("canvas");
            canvas = new Canvas(cw << 5, ch);
        }

        var c = canvas.getContext("2d"),
                spirals = {
                    archimedean: archimedeanSpiral,
                    rectangular: rectangularSpiral
                };
        c.fillStyle = c.strokeStyle = "red";
        c.textAlign = "center";

        exports.cloud = cloud;
    })(typeof exports === "undefined" ? d3.layout || (d3.layout = {}) : exports);
}


/*********************************************/
/* CHORD CHART                               */
/*********************************************/
//https://bl.ocks.org/eesur/a0c31af31b4ae022f61b50af22aa4d30

function drawChordChart(data, target, width) {
    // Call function to draw the Chord Chart
    sankey(target, data, width);
    d3version4.selectAll('.wrapme').call(wrap);
}

function sankey(bind, data, chartWidth, config) {
    d3 = d3version4;
    config = {
        margin: {top: 20, right: 140, bottom: 20, left: 60},
        width: chartWidth,
        height: 500,
        sourceColors: ['#e41a1c', '#377eb8', '#4daf4a', '#FF1493', '#984ea3', '#ff7f00', '#ffff33', '#A52A2A', '#00FF00'],
        targetColors: ['#bbb'],
        ...config
    }
    const {margin, width, height} = config;
    const w = width - margin.left - margin.right;
    const h = height - margin.top - margin.bottom;
    const sourceColors = d3.scaleOrdinal()
            .range(config.sourceColors);
    const targetColors = d3.scaleOrdinal()
            .range(config.targetColors);
    const _data = nodesAndLinks(data.content);



    // set up dom
    const selection = d3.select(bind);
    // destroy/wipe first
    d3.select(bind).select('.js-wrap').remove();
    createDOM(selection);

    // create svg in passed in div
    const svg = selection.select('.js-svg')
            .append('svg')
            .attr('width', width)
            .attr('height', height)
            .append('g')
            .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

    const sankey = d3.sankey()
            .nodeWidth(100)
            .nodePadding(10)
            .extent([[1, 1], [w - 1, h - 6]]);
    sankey(_data);

    const link = svg.append('g')
            .attr('class', 'links')
            .attr('fill', 'none')
            .attr('stroke-opacity', 0.2)
            .selectAll('path')
            .data(_data.links)
            .enter().append('path')
            .attr('class', d => {
                return `source-${d.source.node} target-${d.target.node}`;
            })
            .attr('d', d3.sankeyLinkHorizontal())
            .attr('stroke', d => sourceColors(d.source.node))
            .attr('stroke-width', d => Math.max(1, d.width));

    const node = svg.append('g')
            .attr('class', 'nodes')
            .attr('font-family', 'sans-serif')
            .attr('font-size', 10)
            .selectAll('g')
            .data(_data.nodes)
            .enter().append('g');

    node.append('rect')
            .attr('x', d => (d.type === 'source')
                        ? d.x1
                        : d.x0)
            .attr('y', d => d.y0)
            .attr('class', d => d.type + ' bar')
            .attr('height', d => d.y1 - d.y0)
            .attr('width', d => 30)
            // use colours depending on source or target
            .attr('fill', d => (d.type === 'source')
                        ? sourceColors(d.subIndex)
                        : targetColors(d.subIndex)
            )
            .on('click', function (d) {
                if (d.type === 'source') {
                    highlightSourcePaths(svg, d.index, d.type)
                    updateTitle(selection, d.label, d.value)
                    listInfo(selection, d.sourceLinks, {
                        type: 'source',
                        colorScale: sourceColors
                    })
                } else {
                    highlightSourcePaths(svg, d.index, d.type)
                    updateTitle(selection, d.label, d.value)
                    listInfo(selection, d.targetLinks, {
                        type: 'target',
                        colorScale: sourceColors
                    })
                }
            })
            .on('dblclick', function (d) {
                svg.selectAll('path')
                        .attr('stroke-opacity', 0.2)
            });

    node.append('text')
            .attr('x', d => d.x0 + 40)
            .attr('y', d => d.y0 + 7)
            .attr('dy', '0.35em')
            .attr('class', 'label wrapme')
            .attr('text-anchor', 'start')
            .attr('width', 150)
            .attr('height', d => d.y1 - d.y0)
            .text(d => d.label)
            .filter(d => d.type === 'source')
            .attr('x', d => d.x1 - 10)
            .attr('text-anchor', 'end');

    function highlightSourcePaths(sel, index, type) {
        sel.selectAll('path')
                .attr('stroke-opacity', 0.05)
                // pass in type of source/target
                .filter(`path.${type}-${index}`)
                .attr('stroke-opacity', 0.6);
    }
}

function nodesAndLinks(data) {
    const targetsArray = listTargets(data);
    const sourceNode = createSourceNodes(data);
    const targetNodes = createTargetNodes(data);
    const linksArray = createLinks(data);

    function createSourceNodes(data) {
        const nodes = data.map((d, i) => {
            return {
                node: i,
                subIndex: i,
                label: d.label,
                type: 'source'
            };
        });
        return nodes;
    }
    ;

    function listTargets(data) {
        // list potential targets
        let _targets = [];
        data.forEach(o => {
            // push as flat array
            _targets.push(...o.values.map(d => d.label))
        });
        // remove duplicates
        const targetsArray = [...(new Set(_targets))]
        return targetsArray;
    }
    ;

    function createTargetNodes(data) {
        // create required structure
        const nodes = targetsArray.map((d, i) => {
            return {
                node: (data.length) + i,
                subIndex: i,
                label: d,
                type: 'target'
            };
        });
        return nodes;
    }
    ;

    function createLinks(data) {
        const links = [];
        data.forEach((o, index) => {
            const val = o.values.map(d => {
                return {
                    source: index,
                    target: targetsArray.indexOf(d.label) + data.length,
                    value: d.value,
                    targetLabel: o.label,
                    sourceLabel: d.label
                };
            }).filter(d => d.value !== null)
            links.push(val);
        });
        // return a flattened array
        return links.reduce((a, b) => a.concat(b), []);
    }

    // return the formatted data
    return {
        nodes: sourceNode.concat(targetNodes),
        links: linksArray
    };
}

function listInfo(selection, data, config) {
    config = {
        type: 'source',
        colorScale: null,
        ...config
    }
    const {type, colorScale} = config;

    const join = selection.select('.js-info-ul')
            .selectAll('li')
            .data(data);

    join.enter().append('li')
            .attr('class', 'mb1')
            .merge(join)
            .html(d => {
                const index = d.source.node
                if (type === 'source') {
//          : <span class='bold'>${d.value}</span>
                    return `${createColorBlock(index)} ${d.target.label}`;
                } else {
                    return `${createColorBlock(index)} ${d.source.label}`;
                }
            });

    join.exit().remove();

    function createColorBlock(index) {
        return (`
      <span 
      class='inline-block li-${index}' 
      style='background: ${colorScale(index)}; width: 8px; opacity:0.7;'
      >
      &nbsp;
      </span>
    `);
    }
    ;
}

function createDOM(selection) {
    const container = selection.append('section')
            .attr('class', 'clearfix mx-auto my2 js-wrap');
    // create DOM for svg chart
    const chart = container.append('div')
            .attr('class', 'col col-sm-9');
    chart.append('div')
            .attr('class', 'js-svg');
    // create DOM for displaying info
    const info = container.append('div')
            .attr('class', 'col col-sm-3');
    info.append('h2')
            .attr('class', 'h5 regular js-info-title');
    info.append('ul')
            .attr('class', 'list-reset js-info-ul');

}

function updateTitle(selection, label, value) {
    selection.select('.js-info-title')
            .html(`${label} <span class='js-total'>(total: ${value})</span>`);
}


function wrap(text) {

    var d3 = d3version4;
    text.each(function () {
        var text = d3.select(this);
        var str = text.text().replace("  ", " ");
        var words = str.split(" ").reverse();
        var lineHeight = 20;
        var width = parseFloat(text.attr('width'));
        var height = parseFloat(text.attr('height'));
        var y = parseFloat(text.attr('y'));
        var x = text.attr('x');
        var anchor = text.attr('text-anchor');
        text.attr('class', text.attr('class').replace("wrapme", "").trim());

        var tspan = text.text(null).append('tspan').attr('x', x).attr('y', y).attr('text-anchor', anchor);
        var lineNumber = 0;
        var line = [];
        var word = words.pop();

        while (word) {
            line.push(word);
            tspan.text(line.join(' '));
            if ((tspan.node().getComputedTextLength() > width || word == "\n")) {
                if (((lineNumber + 2) * lineHeight) >= height) {
                    break;
                }
                lineNumber += 1;
                line.pop();
                if (word != "\n") {
                    tspan.text(line.join(' '));
                }
                line = [word];
                tspan = text.append('tspan').attr('x', x).attr('y', y + lineNumber * lineHeight).attr('anchor', anchor).text(word);
            }
            word = words.pop();
        }
    });
}

/*********************************************/
/* Tree                              */
/*********************************************/
//https://bl.ocks.org/mbostock/2966094


function drawTree(data, target, width) {
    var margin = {top: 0, right: 0, bottom: 0, left: 0},
            width = width - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

    if (!window.d3) {
        var d3 = d3version3;
    }

    var tree = d3.layout.tree()
            .separation(function (a, b) {
                return a.parent === b.parent ? 1 : .5;
            })
            .children(function (d) {
                return d.children;
            })
            .size([height, width]);

    var svg = d3.select(target).append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var nodes = tree.nodes(data);

    var link = svg.selectAll(".link")
            .data(tree.links(nodes))
            .enter().append("path")
            .attr("class", "link")
            .attr("d", elbow);

    var node = svg.selectAll(".node")
            .data(nodes)
            .enter().append("g")
            .attr("class", "node")
            .attr("transform", function (d) {
                return "translate(" + d.y + "," + d.x + ")";
            })


    var text = node.append("text")
            .attr("class", "name")
            .attr("x", 8)
            .attr("y", -6)
            .text(function (d) {
                return d.name;
            });

//    node.append('rect')
//            .attr('x', 8)
//            .attr('y', -25)
//            .attr('height', 70)
//            .attr('width', 150)
//            .attr('fill', 'transparent')
//            .style('stroke', 'gray');

    node.append("text")
            .attr("x", 8)
            .attr("y", 8)
            .attr("dy", ".71em")
            .attr("class", "about lifespan")
            .text(function (d) {
                return "d.born +  + d.died";
            });

    node.append("text")
            .attr("x", 8)
            .attr("y", 8)
            .attr("dy", "1.86em")
            .attr("class", "about location")
            .text(function (d) {
                return "d.location";
            });

    function elbow(d, i) {
        return "M" + d.source.y + "," + d.source.x
                + "H" + d.target.y + "V" + d.target.x
                + (d.target.children ? "" : "h" + margin.right);
    }
}

/*********************************************/
/* D3 Bracket Layout                         */
/*********************************************/
//https://bl.ocks.org/mbostock/2966094

function drawBracket(data, target, width) {
    var margin = {top: 30, right: 10, bottom: 10, left: 10},
            width = width - margin.left - margin.right,
            halfWidth = width / 2,
            height = 500 - margin.top - margin.bottom,
            i = 0,
            duration = 500,
            root;


    if (!window.d3) {
        var d3 = d3version3;
    }

    var getChildren = function (d) {
        var a = [];
        if (d.winners)
            for (var i = 0; i < d.winners.length; i++) {
                d.winners[i].isRight = false;
                d.winners[i].parent = d;
                a.push(d.winners[i]);
            }
        if (d.challengers)
            for (var i = 0; i < d.challengers.length; i++) {
                d.challengers[i].isRight = true;
                d.challengers[i].parent = d;
                a.push(d.challengers[i]);
            }
        return a.length ? a : null;
    }
    ;

    var tree = d3.layout.tree()
            .size([height, width])
            ;

    var diagonal = d3.svg.diagonal()
            .projection(function (d) {
                return [d.y, d.x];
            });
    var elbow = function (d, i) {
        var source = calcLeft(d.source);
        var target = calcLeft(d.target);
        var hy = (target.y - source.y) / 2;
        if (d.isRight)
            hy = -hy;
        return "M" + source.y + "," + source.x
                + "H" + (source.y + hy)
                + "V" + target.x + "H" + target.y;
    };
    var connector = elbow;

    var calcLeft = function (d) {
        var l = d.y;
        if (!d.isRight) {
            l = d.y - halfWidth;
            l = halfWidth - l;
        }
        return {x: d.x, y: l};
    };

    var vis = d3.select(target).append("svg")
            .attr("width", width + margin.right + margin.left)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    d3.json(data, function (json) {
        root = data;
        root.x0 = height / 2;
        root.y0 = width / 2;

        var t1 = d3.layout.tree().size([height, halfWidth]).children(function (d) {
            return d.winners;
        }),
                t2 = d3.layout.tree().size([height, halfWidth]).children(function (d) {
            return d.challengers;
        });
        t1.nodes(root);
        t2.nodes(root);

        var rebuildChildren = function (node) {
            node.children = getChildren(node);
            if (node.children)
                node.children.forEach(rebuildChildren);
        }
        rebuildChildren(root);
        root.isRight = false;
        update(root);
    });

    var toArray = function (item, arr) {
        arr = arr || [];
        var i = 0, l = item.children ? item.children.length : 0;
        arr.push(item);
        for (; i < l; i++) {
            toArray(item.children[i], arr);
        }
        return arr;
    };

    function update(source) {
        // Compute the new tree layout.
        var nodes = toArray(source);

        // Normalize for fixed-depth.
        nodes.forEach(function (d) {
            d.y = d.depth * 180 + halfWidth;
        });

        // Update the nodes…
        var node = vis.selectAll("g.node")
                .data(nodes, function (d) {
                    return d.id || (d.id = ++i);
                });

        // Enter any new nodes at the parent's previous position.
        var nodeEnter = node.enter().append("g")
                .attr("class", "node")
                .attr("transform", function (d) {
                    return "translate(" + source.y0 + "," + source.x0 + ")";
                })
                .on("click", click);

        nodeEnter.append("circle")
                .attr("r", 1e-6)
                .style("fill", function (d) {
                    return d._children ? "lightsteelblue" : "#fff";
                });

        nodeEnter.append("text")
                .attr("dy", function (d) {
                    return d.isRight ? 14 : -8;
                })
                .attr("text-anchor", "middle")
                .text(function (d) {
                    return d.name;
                })
                .style("fill-opacity", 1e-6);

        // Transition nodes to their new position.
        var nodeUpdate = node.transition()
                .duration(duration)
                .attr("transform", function (d) {
                    p = calcLeft(d);
                    return "translate(" + p.y + "," + p.x + ")";
                })
                ;

        nodeUpdate.select("circle")
                .attr("r", 4.5)
                .style("fill", function (d) {
                    return d._children ? "lightsteelblue" : "#fff";
                });

        nodeUpdate.select("text")
                .style("fill-opacity", 1);

        // Transition exiting nodes to the parent's new position.
        var nodeExit = node.exit().transition()
                .duration(duration)
                .attr("transform", function (d) {
                    p = calcLeft(d.parent || source);
                    return "translate(" + p.y + "," + p.x + ")";
                })
                .remove();

        nodeExit.select("circle")
                .attr("r", 1e-6);

        nodeExit.select("text")
                .style("fill-opacity", 1e-6);

        // Update the links...
        var link = vis.selectAll("path.link")
                .data(tree.links(nodes), function (d) {
                    return d.target.id;
                });

        // Enter any new links at the parent's previous position.
        link.enter().insert("path", "g")
                .attr("class", "link")
                .attr("d", function (d) {
                    var o = {x: source.x0, y: source.y0};
                    return connector({source: o, target: o});
                });

        // Transition links to their new position.
        link.transition()
                .duration(duration)
                .attr("d", connector);

        // Transition exiting nodes to the parent's new position.
        link.exit().transition()
                .duration(duration)
                .attr("d", function (d) {
                    var o = calcLeft(d.source || source);
                    if (d.source.isRight)
                        o.y -= halfWidth - (d.target.y - d.source.y);
                    else
                        o.y += halfWidth - (d.target.y - d.source.y);
                    return connector({source: o, target: o});
                })
                .remove();

        // Stash the old positions for transition.
        nodes.forEach(function (d) {
            var p = calcLeft(d);
            d.x0 = p.x;
            d.y0 = p.y;
        });

        // Toggle children on click.
        function click(d) {
            if (d.children) {
                d._children = d.children;
                d.children = null;
            } else {
                d.children = d._children;
                d._children = null;
            }
            update(source);
        }
    }

}

/*********************************************/
/* Workflow                                  */
/*********************************************/
function drawWorkflow(data, target, width, phases) {

    if (data.constructor === Object) {
        WorkflowChart.draw(data, target, width, 400, phases);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            WorkflowChart.draw(data, target, width, 400, phases);
        });
    }
    d3version3.selectAll('.wrapme').call(wrap);
}

var WorkflowChart = {
    draw: function (data, target, width, height, phases) {

        var d3 = d3version3;

        var margin = {top: 10, right: 10, bottom: 10, left: 10};

        width = width - margin.left - margin.right;
        height = height - margin.top - margin.bottom;
        var nodesDistance = 30;
        var nodeWidth = (width - ((phases) * nodesDistance)) / phases;
        var nodeHeight = nodeWidth / 2;

        var container = d3.select(target).html("");

        data.nodes.forEach(function (d) {
            d.x = ((d.orderExec - 1) * (nodeWidth + nodesDistance)) + margin.left;
            d.y = height / 2;
            if (d.siblings > 1) {
                d.y = ((height / d.siblings) * d.position) - nodeHeight;
            }
            if (d.reusedFrom != null) {
                d.kind = 6;
            }
            if (d.reusedBy != null) {
                d.kind = 3;
            }
        });

        var svg = container.append("svg")
                .attr("width", width)
                .attr("height", height);

        // define the nodes
        var node = svg.selectAll(".node")
                .data(data.nodes)
                .enter().append("g")
                .attr("transform", function (d) {
                    return "translate(" + d.x + "," + d.y + ")";
                });


        // add the nodes
        node.append('rect')
                .attr('x', 0)
                .attr('y', -(nodeHeight / 2))
                .attr('height', nodeHeight)
                .attr('width', nodeWidth)
                .style('stroke', '#337ab7')
                .style('stroke-width', 2)
                .style("stroke", function (d) {
                    if (d.kind == 1) {
                        return "#666666";
                    } else if (d.kind == 2) {
                        return "B85450";
                    } else if (d.kind == 3) {
                        return "#82B366";
                    } else if (d.kind == 4) {
                        return "#6C8EBF";
                    } else if (d.kind == 5) {
                        return "#9673A6";
                    } else if (d.kind == 6) {
                        return "#D6B656";
                    } else if (d.kind == 7) {
                        return "#D79B00";
                    } else {
                        return "#000000";
                    }
                })
                .style("fill", function (d) {
                    if (d.kind == 1) {
                        return "#F5F5F5";//gray
                    } else if (d.kind == 2) {
                        return "#F8CECC";//red
                    } else if (d.kind == 3) {
                        return "#D5E8D4";//green
                    } else if (d.kind == 4) {
                        return "#DAE8FC"; //blue
                    } else if (d.kind == 5) {
                        return "#E1D5E7"; //purple
                    } else if (d.kind == 6) {
                        return "#FFF2CC"; //yellow
                    } else if (d.kind == 7) {
                        return "#FFE6CC"; //orange
                    } else {
                        return "#FFFFFF";//none
                    }
                });

        // add the nodes text
        node.append("text")
                .attr('x', nodeWidth / 2)
                .attr('y', 0)
                .attr('height', nodeHeight)
                .attr('width', nodeWidth)
                .attr("class", "wrapme")
                .attr("text-anchor", "middle")
                .text(function (d) {
                    return d.name;
                });


        // add the links and the arrows
        svg.append("svg:g").selectAll("path")
                .data(data.links)
                .enter().append("svg:path")
                .attr("class", "link")
                .attr("marker-end", "url(#end)")
                .style('stroke-width', 2)
                .attr("id", function (d) {
                    return d.source.name + "_" + d.target.name + "_" + d.name;
                })
                .attr("d", function (d) {
                    console.log(d.target.reusedFrom);
                    if(d.target.reusedFrom != null && d.source.reusedFrom != d.target.reusedFrom){
                        return null;
                    }
                    var targetX = d.target.x - 12;
                    var dx = d.source.x + nodeWidth;
                    //rx ry x-axis-rotation large-arc-flag sweep-flag x y
                    return "M" +
                            dx + "," +
                            d.source.y + "A" +
                            0 + "," + 0 + " 0 0,0 " +
                            targetX + "," +
                            d.target.y;
                });

        // build the arrow.
        svg.append("svg:defs").selectAll("marker")
                .data(["end"])      // Different link/path types can be defined here
                .enter().append("svg:marker")    // This section adds in the arrows
                .attr("id", String)
                .attr("viewBox", "0 -5 10 10")
                .attr("markerWidth", 6)
                .attr("markerHeight", 6)
//                .attr("orient", "auto")
                .style('stroke', '#4D4D4D')
                .style('fill', '#4D4D4D')
                .append("svg:path")
                .attr("d", "M0,-5L10,0L0,5");


        // add tooltip information
        var tip;
        node.on("mouseover", function (d) {

            if (tip)
                tip.remove();


            tip = svg.append("g")
                    .attr("transform", "translate(" + 0 + "," + 0 + ")");

            var rect = tip.append("rect")
                    .style("fill", "white");

            tip.append("text")
                    .text(d.name)
                    .attr("class", "node-label")
                    .attr("y", 20)
                    .attr("x", 5);

            tip.append("text")
                    .text("Description: " + d.description)
                    .attr('height', height)
                    .attr('width', width)
                    .attr("class", "wrapme")
                    .attr("text-anchor", "start")
                    .attr("x", 5)
                    .attr("y", 80);

            tip.append("text")
                    .text("Author: " + d.author)
                    .attr("x", 5)
                    .attr("y", 40);

            if (d.reusedFrom) {
                tip.append("text")
                        .text("Reused From: " + d.reusedFrom)
                        .attr("y", 60)
                        .attr("x", 5);
            }

            if (d.reusedBy) {
                tip.append("text")
                        .text("Reused By: " + d.reusedBy)
                        .attr("y", 60)
                        .attr("x", 5);
            }

            d3version3.selectAll('.wrapme').call(wrap);
            var bbox = tip.node().getBBox();
            rect.attr("width", bbox.width + 5)
                    .attr("height", bbox.height + 5);

        });

        node.on("mouseout", function () {
            if (tip)
                tip.remove();
        });

        svg.append("svg:image")
                .attr("xlink:href", "/" + window.location.pathname.split('/')[1] + "/resources/images/workflow-graph-legend.png")
                .attr("x", 0)
                .attr("y", height - 80)
                .attr("width", "30%")
                .attr("height", "30%");


    }
};


/*********************************************/
/* PROVENANCE GRAPH                          */
/*********************************************/
function drawProvenanceGraph(data, target, width) {

    data = mountDataToProvenance(data);
    // Call function to draw the Radar chart
    if (data.constructor === Object) {
        ProvenanceGraphChart.draw(data, target, width);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            ProvenanceGraphChart.draw(data, target, width);
        });
    }
    d3version4.selectAll('.wrapme').call(wrap);
}

function mountDataToProvenance(itemData) {
    var info = "";
    for (var i in itemData.dataProperties) {
        info = info += i.toUpperCase() + ": " + itemData.dataProperties[i] + " \n ";
    }

    var objectName = itemData.resource;
    if (itemData.dataProperties.name != undefined) {
        objectName = itemData.dataProperties.name;
    }
    objectName = objectName.replace(".", "_");
    var graphData = {
        "nodes": [
            {
                "name": objectName,
                "group": 0,
                "class": itemData.dataProperties.type,
                "info": info
            }
        ],
        "links": []
    };

    var groupId = 1;
    for (var j in itemData.asserted) {
        for (var k = 0; k < itemData.asserted[j].length; k++) {
            var item = itemData.asserted[j][k];
            var name = item.name;
            name = name.replace(".", "_");
            if (graphData.links.find(x => x.target.name == name) == null) {
                graphData.nodes.push({
                    "name": name, "group": groupId, "id": item.id, "class": item.type
                });
                graphData.links.push({
                    "source": 0, "target": groupId, "value": 1, "type": "arrow", "name": j, "linknum": 1
                });
            } else {
                var target = graphData.nodes.find(x => x.name == name).group;
                if (target) {
                    var other = graphData.links.find(x => x.target == target);
                    if (other.way == null) {
                        other.name = other.name + j;
                    } else {
                        var linknum = graphData.links.find(x => x.target == target).linknum + 1;
                        graphData.links.push({
                            "source": 0, "target": target, "value": 1, "type": "arrow", "name": j, "linknum": linknum
                        });
                    }
                }
            }
            groupId++;
        }
    }
    for (var j in itemData.inferred) {
        for (var k = 0; k < itemData.inferred[j].length; k++) {
            var item = itemData.inferred[j][k];
            var name = item.name;
            name = name.replace(".", "_");
            if (graphData.nodes.find(x => x.name == name) == null) {
                graphData.nodes.push({
                    "name": name, "group": groupId, "id": item.id, "class": item.type
                });
                graphData.links.push({
                    "source": 0, "target": groupId, "value": 1, "type": "arrow", "way": "interoperate", "name": j, "linknum": 1
                });
                groupId++;
            } else {
                var target = graphData.nodes.find(x => x.name == name).group;
                if (target) {
                    var other = graphData.links.find(x => x.target == target);
                    if (other.way == "interoperate") {
                        other.name = other.name + " / " + j;
                    } else {
                        var linknum = graphData.links.find(x => x.target == target).linknum + 1;
                        graphData.links.push({
                            "source": 0, "target": target, "value": 1, "type": "arrow", "way": "interoperate", "name": j, "linknum": linknum
                        });
                    }
                }
            }
        }
    }
    for (var i in graphData.links) {
        if (graphData.links[i].name.indexOf("was Influenced By /") != -1) {
            graphData.links[i].name = graphData.links[i].name.replace('was Influenced By /', '*');
        } else if (graphData.links[i].name.indexOf("/ was Influenced By") != -1) {
            graphData.links[i].name = graphData.links[i].name.replace('/ was Influenced By', '*');
        }
        if (graphData.links[i].name.indexOf("influenced /") != -1) {
            graphData.links[i].name = graphData.links[i].name.replace('influenced /', '*');
        } else if (graphData.links[i].name.indexOf("/ influenced") != -1) {
            graphData.links[i].name = graphData.links[i].name.replace('/ influenced', '*');
        }
    }
    return graphData;
}

var ProvenanceGraphChart = {

    draw: function (data, target, width) {

        var d3 = d3version3;

        // get the data
        //var nodecolor = d3.scale.category20();

        var nodes = data.nodes;

        // Compute the distinct nodes from the links.
        var links = data.links;

        var height = 600;

        var force = d3.layout.force()
                .nodes(data.nodes)
                .links(links)
                .size([width, height])
                .linkDistance(function (d) {
                    return 1 / d.value * 250;
                })

                .charge(-1000)
                .on("tick", tick)
                .start();

        // Set the range
        var v = d3.scale.linear().range([0, 100]);

        // Scale the range of the data
        v.domain([0, d3.max(links, function (d) {
                return d.value;
            })]);

        // asign a type per value to encode opacity
        links.forEach(function (link) {
            if (v(link.value) <= 25) {
                link.type = "twofive";
            } else if (v(link.value) <= 50 && v(link.value) > 25) {
                link.type = "fivezero";
            } else if (v(link.value) <= 75 && v(link.value) > 50) {
                link.type = "sevenfive";
            } else if (v(link.value) <= 100 && v(link.value) > 75) {
                link.type = "onezerozero";
            }
        });

        nodes.forEach(function (node) {

            //agent orange
            if (node.class == "researcher") {
                node.kind = 10;
            } else if (node.class == "developer") {
                node.kind = 11;
            } else if (node.class == "researchgroup") {
                node.kind = 12;
            } else if (node.class == "institution") {
                node.kind = 13;
            } else if (node.class == "wfms") {
                node.kind = 14;
            } else if (node.class == "service") {
                node.kind = 15;
            }
            //entity yellow
            else if (node.class == "experiment") {
                node.kind = 20;
            } else if (node.class == "workflow") {
                node.kind = 21;
            } else if (node.class == "activity") {
                node.kind = 22;
            } else if (node.class == "port") {
                node.kind = 23;
            } else if (node.class == "data") {
                node.kind = 24;
            } else if (node.class == "document") {
                node.kind = 25;
            }
            //activity blue
            else if (node.class == "workflowexecution") {
                node.kind = 30;
            } else if (node.class == "activityexecution") {
                node.kind = 31;
            }
            //location brown
            else if (node.class == "city") {
                node.kind = 40;
            }
        });

        var container = d3.select(target).html("");

        var svg = container.append("svg")
                .attr("width", width)
                .attr("height", height);

        // build the arrow.
        svg.append("svg:defs").selectAll("marker")
                .data(["end"])      // Different link/path types can be defined here
                .enter().append("svg:marker")    // This section adds in the arrows
                .attr("id", String)
                .attr("viewBox", "0 -5 10 10")
                .attr("refX", 30)
                .attr("refY", -1.5)
                .attr("markerWidth", 6)
                .attr("markerHeight", 6)
                .attr("orient", "auto")
                .append("svg:path")
                .attr("d", "M0,-5L10,0L0,5");

        // add the links and the arrows
        var path = svg.append("svg:g").selectAll("path")
                .data(force.links())
                .enter().append("svg:path")
                .attr("class", function (d) {
                    var classes = "link " + d.type;
                    if (d.way == "interoperate") {
                        classes += " interoperate ";
                    }
                    return classes;
                })
                .attr("marker-end", "url(#end)")
                .attr("id", function (d) {
                    return d.source.name + "_" + d.target.name + "_" + d.name;
                });

        // add link labels
        svg.selectAll(".link-label")
                .data(data.links)
                .enter().append('svg:text')
                .append("svg:textPath")
                .attr({
                    "class": "link-label",
                    "text-anchor": "middle"
                })
                .attr("xlink:href", function (d) {
                    return "#" + d.source.name + "_" + d.target.name + "_" + d.name;
                })
                .style("text-anchor", "middle")
                .attr("startOffset", "50%")
                .text(function (d) {
                    return d.name.toLowerCase();
                });

        // define the nodes
        var node = svg.selectAll(".node")
                .data(force.nodes())
                .enter().append("g")
                .attr("class", "node")
                .call(force.drag);


        svg.append("svg:clipPath")
                .attr("id", "clip")
                .append("svg:circle")
                .attr('cx', 0)
                .attr('cy', 0)
                .attr('r', 16);

        svg.append("svg:clipPath")
                .attr("id", "clipG")
                .append("svg:circle")
                .attr('cx', 0)
                .attr('cy', 0)
                .attr('r', 32);



        // add the nodes
        node.append("circle")
                .attr("r", 16)
                .style("fill", function (d) {
                    //main object black
                    if (d.kind == 1) {
                        return "#000000";
                    }
                    //agent orange
                    if (d.kind == 10) {
                        return "#0B4237";
                    } else if (d.kind == 11) {//green
                        return "#006551 ";
                    } else if (d.kind == 12) {
                        return "#067F67";
                    } else if (d.kind == 13) {
                        return "#169A80";
                    } else if (d.kind == 14) {
                        return "#32A38D";
                    } else if (d.kind == 15) {
                        return "#58BDA9";
                    }
                    //entity yellow
                    else if (d.kind == 20) {
                        return "#150A52";
                    } else if (d.kind == 21) {
                        return "#1C0D6D"
                    } else if (d.kind == 22) {
                        return "#29178A";
                    } else if (d.kind == 23) {
                        return "#3E2AA8";
                    } else if (d.kind == 24) {
                        return "#5746B1";
                    } else if (d.kind == 25) {
                        return "#796AC7";
                    }
                    //activity blue
                    else if (d.kind == 30) {
                        return "#B57200";
                    } else if (d.kind == 31) {
                        return "#E99300";
                    }
                    //location brown
                    else if (d.kind == 40) {
                        return "#162742";
                    }
                });

        //add images at the nodes
        node.append("svg:image")
                .attr("xlink:href", function (d) {
                    //agent orange
                    if (d.kind >= 10 && d.kind <= 15) {
                        return "/" + window.location.pathname.split('/')[1] + "/resources/images/pentagon.png";
                    }
                    //entity yellow
                    if (d.kind >= 20 && d.kind <= 25) {
                        return "/" + window.location.pathname.split('/')[1] + "/resources/images/oval.png";
                    }
                    //activity blue
                    if (d.kind >= 30 && d.kind <= 31) {
                        return "/" + window.location.pathname.split('/')[1] + "/resources/images/rectangle-blue.png";
                    }
                    //location brown
                    else if (d.kind == 40) {
                        return "/" + window.location.pathname.split('/')[1] + "/resources/images/rectangle-brown.png";
                    }
                })
                .attr("x", "-8px")
                .attr("y", "-8px")
                .attr("width", "16px")
                .attr("height", "16px");

        // add the text
        node.append("text")
                .attr("x", 15)
                .attr("y", 0)
                .attr("dy", ".35em")
                .attr("width", 400)
                .attr("height", 25)
                .attr('class', 'wrapme ')
                .attr('text-anchor', "start")
                .text(function (d) {
                    return d.name.replace("  ", " ");
                });

        // add tooltip information
        var tip;
        node.on("dblclick", function (d) {
            if (tip)
                tip.remove();

            tip = svg.append("g")
                    .attr("transform", "translate(" + 5 + "," + 5 + ")");

            var rect = tip.append("rect")
                    .style("fill", "white")
                    .style("stroke", "steelblue");

            tip.append("text")
                    .text(d.name)
                    .attr("x", (width / 2) - 40)
                    .attr("y", 20)
                    .attr('class', 'wrapme node-label')
                    .attr('width', width - 50)
                    .attr('height', height)
                    .attr('text-anchor', "middle");

            var title = tip.append("svg:image")
                    .attr("x", width - 60)
                    .attr("y", 0)
                    .attr("xlink:href", "/" + window.location.pathname.split('/')[1] + "/resources/images/go.png")
                    .attr('width', "36px")
                    .attr('height', "36px");

            title.on("click", function () {
                if (d.kind && d.id) {
                    window.open("/" + window.location.pathname.split("/")[1] + "/ontology/" + d.class + "_" + d.id);
                }
            });
            if (d.info) {
                tip.append("text")
                        .text(d.info)
                        .attr("x", 5)
                        .attr("y", 70)
                        .attr('class', 'wrapme ')
                        .attr('width', width - 10)
                        .attr('height', height)
                        .attr('text-anchor', "start");
            }

            d3version4.selectAll('.wrapme').call(wrap);
            var bbox = tip.node().getBBox();
            rect.attr("width", width - 20)
                    .attr("height", bbox.height + 10);
            if ((bbox.height + 10) > height) {
                svg.attr("width", width - 10)
                        .attr("height", bbox.height + 20);
            }
        });

        container.on("click", function (d) {
            if (tip)
                tip.remove();
        });

        svg.append("svg:image")
                .attr("xlink:href", "/" + window.location.pathname.split('/')[1] + "/resources/images/provenance-graph-legend.png")
                .attr("x", -15)
                .attr("y", 0)
                .attr("width", "20%")
                .attr("height", "20%")
                .on('mouseenter', function () {
                    d3.select(this)
                            .transition()
                            .attr("height", "75%")
                            .attr("width", "75%");
                }).on('mouseleave', function () {
            d3.select(this)
                    .transition()
                    .attr("width", "20%")
                    .attr("height", "20%");
        });


        // add the curvy lines
        function tick() {

            path.attr("d", function (d) {
                var dx = d.target.x - d.source.x,
                        dy = d.target.y - d.source.y,
                        dr = Math.sqrt(dx * dx + dy * dy);

                if (isNaN(d.linknum) || d.linknum == null || d.linknum == undefined || d.linknum == 1) {
                    d.linknum = 1;
                    //rx ry x-axis-rotation large-arc-flag sweep-flag x y
                    return "M" +
                            d.source.x + "," +
                            d.source.y + "A" +
                            dr + "," + dr + " 0 0,1 " +
                            d.target.x + "," +
                            d.target.y;
                } else {
                    return "M" +
                            d.source.x + "," +
                            d.source.y + "A" +
                            dr + "," + dr + " 0 0,0 " +
                            d.target.x + "," +
                            d.target.y;
                }
            });

            node.attr("transform", function (d) {
                return "translate(" + d.x + "," + d.y + ")";
            });
        }

    }
};


/*********************************************/
/* Bubble Menu                               */
/*http://jsfiddle.net/xameeramir/zcgLybpd/   */
/*********************************************/

function drawBubbleMenu(data, target, width) {

//    data = mountDataToBubble(data);

    // Call function to draw the Radar chart
    if (data.constructor === Object) {
        BubbleMenu.draw(data, target, width);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            BubbleMenu.draw(data, target, width);
        });
    }
    d3version4.selectAll('.wrapme').call(wrap);
}

//function mountDataToBubble(itemData) {
//    
//    var root = {"children":
//                [
//                    {"name":"workflowexecution.3","id":"3","type":"workflowexecution","label":"Análise do metabolismo em novilhas com fenótipos divergentes para EA","author":"Danieli Cabral da Silva","description":"Processo de avaliação e classificação de animais por CAR e GPR e ECA, e análise de acordo com o consumo, a digestibilidade, partição energética, emissões de CH4 entérico, balanço de nitrogênio, metabólitos sanguíneos e termografia infravermelha.","start":"2018-06-16 09:25:00.0","end":"2018-06-17 12:25:00.0","address":"/experiments/workflows/5","children":[{"name":"activityexecution.13","id":"13","type":"activityexecution","label":"Cálculo CAR","author":"Danieli Cabral da Silva","description":"Cálculo do índice de consumo alimentar residual (CAR) dos animais.","start":"2018-06-16 20:47:00.0","end":"2018-06-16 21:47:00.0","address":"/experiments/activities/11"},{"name":"activityexecution.14","id":"14","type":"activityexecution","label":"Cálculo GPR","author":"Danieli Cabral da Silva","description":"Cálculo do índice de ganho de peso residual (GPR) dos animais.","start":"2018-06-16 20:48:00.0","end":"2018-06-16 21:48:00.0","address":"/experiments/activities/12"},{"name":"activityexecution.15","id":"15","type":"activityexecution","label":"Cálculo ECA","author":"Danieli Cabral da Silva","description":"Cálculo do índice de eficiência de conversão alimentar (ECA) dos animais.","start":"2018-06-16 20:48:00.0","end":"2018-06-16 21:48:00.0","address":"/experiments/activities/13"}]},
//                    {"name":"workflowexecution.3","id":"3","type":"workflowexecution","label":"Análise do metabolismo em novilhas com fenótipos divergentes para EA","author":"Danieli Cabral da Silva","description":"Processo de avaliação e classificação de animais por CAR e GPR e ECA, e análise de acordo com o consumo, a digestibilidade, partição energética, emissões de CH4 entérico, balanço de nitrogênio, metabólitos sanguíneos e termografia infravermelha.","start":"2018-06-16 09:25:00.0","end":"2018-06-17 12:25:00.0","address":"/experiments/workflows/5","children":[{"name":"activityexecution.13","id":"13","type":"activityexecution","label":"Cálculo CAR","author":"Danieli Cabral da Silva","description":"Cálculo do índice de consumo alimentar residual (CAR) dos animais.","start":"2018-06-16 20:47:00.0","end":"2018-06-16 21:47:00.0","address":"/experiments/activities/11"},{"name":"activityexecution.14","id":"14","type":"activityexecution","label":"Cálculo GPR","author":"Danieli Cabral da Silva","description":"Cálculo do índice de ganho de peso residual (GPR) dos animais.","start":"2018-06-16 20:48:00.0","end":"2018-06-16 21:48:00.0","address":"/experiments/activities/12"},{"name":"activityexecution.15","id":"15","type":"activityexecution","label":"Cálculo ECA","author":"Danieli Cabral da Silva","description":"Cálculo do índice de eficiência de conversão alimentar (ECA) dos animais.","start":"2018-06-16 20:48:00.0","end":"2018-06-16 21:48:00.0","address":"/experiments/activities/13"}]},
//                    {"name":"workflowexecution.4","id":"4","type":"workflowexecution","label":"Análise da EA sobre a puberdade e características ovarianas","author":"Adolfo Pérez Fonseca","description":"Estudar e caracterizar os parâmetros reprodutivos até a primeira concepção, incluindo-se idade e peso à puberdade, comportamento de estro, dinâmica folicular, resposta a protocolos hormonais e fertilidade em novilhas Girolando. Relacionar a eficiência nutricional com idade e peso à puberdade e alguns parâmetros reprodutivos em novilhas Girolando.","start":"2018-06-17 16:42:00.0","end":"2018-06-17 22:42:00.0","address":"/experiments/workflows/6","children":[{"name":"activityexecution.20","id":"20","type":"activityexecution","label":"Cálculo do CAR","author":"Adolfo Pérez Fonseca","description":"Cálculo do Consumo alimentar Residual (CAR) dos animais.","start":"2018-06-17 19:39:00.0","end":"2018-06-17 19:40:00.0","address":"/experiments/activities/18"}]}
//                ],"name":"Dados Coletados"};
//    return root;
//}

var BubbleMenu = {

    draw: function (root, target, width) {
        
        var d3 = d3version3;
        

        var w = width;
        var h = Math.ceil(w * 0.5);
        var oR = 0;
        var nTop = 0;

        var svgContainer = d3.select(target)
                .style("height", h + "px");

        var svg = svgContainer.append("svg")
                .attr("class", "mainBubbleSVG")
                .attr("width", w)
                .attr("height", h)
                .on("mouseleave", function () {
                    d3version4.selectAll('.wrapme').call(wrap);
                    resetBubbles(width);
                });

        var mainNote = svg.append("text")
                .attr("id", "bubbleItemNote")
                .attr("x", 10)
                .attr("y", h - 110)
                .attr("width", w - 10)
                .attr("height", h - 10)
                .attr("font-size", 12)
                .attr("dominant-baseline", "middle")
                .attr("alignment-baseline", "middle")
                .style("fill", "#888888")
                .text(function (d) {
                    return "";
                });


        var bubbleObj = svg.selectAll(".topBubble")
                .data(root.children)
                .enter().append("g")
                .attr("id", function (d, i) {
                    return "topBubbleAndText_" + i
                });

        nTop = root.children.length;
        oR = w / (2 + 3 * nTop);

        h = Math.ceil(w / nTop * 2);
        svgContainer.style("height", h + "px");

        var colVals = d3.scale.category10();

        bubbleObj.append("circle")
                .attr("class", "topBubble")
                .attr("id", function (d, i) {
                    return "topBubble" + i;
                })
                .attr("r", function (d) {
                    return oR;
                })
                .attr("cx", function (d, i) {
                    return oR * (3 * (1 + i) - 1);
                })
                .attr("cy", (h + oR) / 3)
                .style("fill", function (d, i) {
                    if (d.kind == "generated") {
                        return colVals(1);
                    } else if (d.kind == "reused") {
                        return colVals(3);
                    } else {
                        return colVals(i);
                    }
                }) // #1f77b4
                .attr("cursor", "pointer")
                .style("opacity", 0.3)
                .on("click", function (d, i) {
                    window.open("/" + window.location.pathname.split("/")[1] + d.address);
                })
                .on("mouseover", function (d, i) {
                    activateBubble(d, i);
                    d3version4.selectAll('.wrapme').call(wrap);
                }).append("svg:title")
                .text(function (d) {
                    return d.address;
                });



        bubbleObj.append("text")
                .attr("class", "topBubbleText wrapme")
                .attr("x", function (d, i) {
                    return oR * (3 * (1 + i) - 1);
                })
                .attr("y", (h + oR) / 3.5)
                .attr("width", oR)
                .attr("height", oR)
                .style("fill", function (d, i) {
                    if (d.kind == "generated") {
                        return colVals(1);
                    } else if (d.kind == "reused") {
                        return colVals(3);
                    } else {
                        return colVals(i);
                    }
                }) // #1f77b4
                .attr("font-size", 16)
                .attr("text-anchor", "middle")
                .attr("dominant-baseline", "middle")
                .attr("alignment-baseline", "middle")
                .text(function (d) {
                    return d.label
                })
                .on("click", function (d, i) {
                    window.open("/" + window.location.pathname.split("/")[1] + d.address);
                })
                .on("mouseover", function (d, i) {
                    activateBubble(d, i);
                    d3version4.selectAll('.wrapme').call(wrap);
                });


        for (var iB = 0; iB < nTop; iB++) {
            var childBubbles = svg.selectAll(".childBubble" + iB)
                    .data(root.children[iB].children)
                    .enter().append("g");


            childBubbles.append("circle")
                    .attr("class", "childBubble" + iB)
                    .attr("id", function (d, i) {
                        return "childBubble_" + iB + "sub_" + i;
                    })
                    .attr("r", function (d) {
                        return oR / 3.0;
                    })
                    .attr("cx", function (d, i) {
                        return (oR * (3 * (iB + 1) - 1) + oR * 1.5 * Math.cos((i - 1) * 45 / 180 * Math.PI));
                    })
                    .attr("cy", function (d, i) {
                        return ((h + oR) / 3 + oR * 1.5 * Math.sin((i - 1) * 45 / 180 * Math.PI));
                    })
                    .attr("cursor", "pointer")
                    .style("opacity", 0.5)
                    .style("fill", "#eee")
                    .on("click", function (d, i) {
                        window.open("/" + window.location.pathname.split("/")[1] + d.address);
                    })
                    .on("mouseover", function (d, i) {
                        var noteText = "";
                        noteText += "Description: " + d.description + " \n ";
                        noteText += "Author: " + d.author + " \n ";
                        noteText += "Started at : " + d.start + " ";
                        noteText += "Ended at : " + d.end;

                        d3.select("#bubbleItemNote")
                                .text(noteText)
                                .attr("class", "wrapme");

                        d3version4.selectAll('.wrapme').call(wrap);
                    })
                    .append("svg:title")
                    .text(function (d) {
                        return d.address;
                    });

            childBubbles.append("text")
                    .attr("class", "childBubbleText" + iB)
                    .attr("x", function (d, i) {
                        return (oR * (3 * (iB + 1) - 1) + oR * 1.5 * Math.cos((i - 1) * 45 / 180 * Math.PI));
                    })
                    .attr("y", function (d, i) {
                        return ((h + oR) / 3 + oR * 1.5 * Math.sin((i - 1) * 45 / 180 * Math.PI));
                    })
                    .attr("width", oR)
                    .attr("height", oR)
                    .style("opacity", 0.5)
                    .attr("text-anchor", "middle")
                    .style("fill", function (d, i) {
                        if (d.kind == "generated") {
                            return colVals(1);
                        } else if (d.kind == "reused") {
                            return colVals(3);
                        } else {
                            return colVals(iB);
                        }
                    }) // #1f77b4
                    .attr("font-size", 6)
                    .attr("cursor", "pointer")
                    .attr("dominant-baseline", "middle")
                    .attr("alignment-baseline", "middle")
                    .text(function (d) {
                        return d.label
                    })
                    .on("click", function (d, i) {
                        window.open("/" + window.location.pathname.split("/")[1] + d.address);
                    });

            svg.append("svg:image")
                    .attr("xlink:href", "/" + window.location.pathname.split('/')[1] + "/resources/images/entity-graph-legend.png")
                    .attr("x", 0)
                    .attr("y", -12)
                    .attr("width", "20%")
                    .attr("height", "20%")
                    .on('mouseenter', function () {
                        d3.select(this)
                                .transition()
                                .attr("height", "75%")
                                .attr("width", "75%");
                    }).on('mouseleave', function () {
                d3.select(this)
                        .transition()
                        .attr("width", "20%")
                        .attr("height", "20%");
            });

        }

        resetBubbles = function (width) {
            w = width;
            oR = w / (2 + 3 * nTop);

            h = Math.ceil(w / nTop * 2);
            svgContainer.style("height", h + "px");

            mainNote.attr("y", h - 110);

            svg.attr("width", w);
            svg.attr("height", h);

            d3.select("#bubbleItemNote").text("");

            var t = d3;

            t.selectAll(".topBubble")
                    .attr("r", function (d) {
                        return oR;
                    })
                    .attr("cx", function (d, i) {
                        return oR * (3 * (1 + i) - 1);
                    })
                    .attr("cy", (h + oR) / 3);

            t.selectAll(".topBubbleText")
                    .attr("font-size", 16)
                    .attr("x", function (d, i) {
                        return oR * (3 * (1 + i) - 1);
                    })
                    .attr("y", (h + oR) / 3.5)
                    .attr("class", "topBubbleText wrapme")
                    .attr("width", oR)
                    .attr("height", oR)
                    .attr("text-anchor", "middle")
                    .attr("dominant-baseline", "middle")
                    .attr("alignment-baseline", "middle")
                    .text(function (d) {
                        return d.label
                    });


            for (var k = 0; k < nTop; k++) {
                t.selectAll(".childBubbleText" + k)
                        .attr("x", function (d, i) {
                            return (oR * (3 * (k + 1) - 1) + oR * 1.5 * Math.cos((i - 1) * 45 / 180 * Math.PI));
                        })
                        .attr("y", function (d, i) {
                            return ((h + oR) / 3 + oR * 1.5 * Math.sin((i - 1) * 45 / 180 * Math.PI));
                        })
                        .attr("font-size", 6)
                        .style("opacity", 0.5);

                t.selectAll(".childBubble" + k)
                        .attr("r", function (d) {
                            return oR / 3.0;
                        })
                        .style("opacity", 0.5)
                        .attr("cx", function (d, i) {
                            return (oR * (3 * (k + 1) - 1) + oR * 1.5 * Math.cos((i - 1) * 45 / 180 * Math.PI));
                        })
                        .attr("cy", function (d, i) {
                            return ((h + oR) / 3 + oR * 1.5 * Math.sin((i - 1) * 45 / 180 * Math.PI));
                        });

            }

            d3version4.selectAll('.wrapme').call(wrap);

        }


        activateBubble = function (d, i) {
            // increase this bubble and decrease others
            var t = d3;

            t.selectAll(".topBubble")
                    .attr("cx", function (d, ii) {
                        if (i == ii) {
                            // Nothing to change
                            return oR * (3 * (1 + ii) - 1) - 0.6 * oR * (ii - 1);
                        } else {
                            // Push away a little bit
                            if (ii < i) {
                                // left side
                                return oR * 0.6 * (3 * (1 + ii) - 1);
                            } else {
                                // right side
                                return oR * (nTop * 3 + 1) - oR * 0.6 * (3 * (nTop - ii) - 1);
                            }
                        }
                    })
                    .attr("r", function (d, ii) {
                        if (i == ii)
                            return oR * 1.8;
                        else
                            return oR * 0.8;
                    });

            t.selectAll(".topBubbleText")
                    .attr("x", function (d, ii) {
                        if (i == ii) {
                            // Nothing to change
                            return oR * (3 * (1 + ii) - 1) - 0.6 * oR * (ii - 1);
                        } else {
                            // Push away a little bit
                            if (ii < i) {
                                // left side
                                return oR * 0.6 * (3 * (1 + ii) - 1);
                            } else {
                                // right side
                                return oR * (nTop * 3 + 1) - oR * 0.6 * (3 * (nTop - ii) - 1);
                            }
                        }
                    })
                    .attr("y", function (d, ii) {
                        if (i == ii) {
                            return (h + oR) / 4
                        } else {
                            return (h + oR) / 3.5
                        }
                    })
                    .attr("class", "topBubbleText wrapme")
                    .attr("font-size", function (d, ii) {
                        if (i == ii)
                            return 16 * 1.5;
                        else
                            return 16 * 0.6;
                    })
                    .attr("width", function (d, ii) {
                        if (i == ii)
                            return oR * 1.8;
                        else
                            return oR * 0.8;
                    })
                    .attr("height", function (d, ii) {
                        if (i == ii)
                            return oR * 1.8;
                        else
                            return oR * 0.8;
                    })
                    .attr("text-anchor", "middle")
                    .attr("dominant-baseline", "middle")
                    .attr("alignment-baseline", "middle")
                    .text(function (d) {
                        return d.label
                    });

            var signSide = -1;
            for (var k = 0; k < nTop; k++) {
                signSide = 1;
                if (k < nTop / 2)
                    signSide = 1;
                t.selectAll(".childBubbleText" + k)
                        .attr("x", function (d, i) {
                            return (oR * (3 * (k + 1) - 1) - 0.6 * oR * (k - 1) + signSide * oR * 2.5 * Math.cos((i - 1) * 45 / 180 * Math.PI));
                        })
                        .attr("y", function (d, i) {
                            return ((h + oR) / 3 + signSide * oR * 2.5 * Math.sin((i - 1) * 45 / 180 * Math.PI));
                        })
                        .attr("font-size", function () {
                            return (k == i) ? 12 : 6;
                        })
                        .style("opacity", function () {
                            return (k == i) ? 1 : 0;
                        });

                t.selectAll(".childBubble" + k)
                        .attr("cx", function (d, i) {
                            return (oR * (3 * (k + 1) - 1) - 0.6 * oR * (k - 1) + signSide * oR * 2.5 * Math.cos((i - 1) * 45 / 180 * Math.PI));
                        })
                        .attr("cy", function (d, i) {
                            return ((h + oR) / 3 + signSide * oR * 2.5 * Math.sin((i - 1) * 45 / 180 * Math.PI));
                        })
                        .attr("r", function () {
                            return (k == i) ? (oR * 0.55) : (oR / 3.0);
                        })
                        .style("opacity", function () {
                            return (k == i) ? 1 : 0;
                        });
            }
            var noteText = "";
            noteText += "Description: " + d.description + " \n ";
            noteText += "Author: " + d.author + " \n ";
            noteText += "Started at : " + d.start + " ";
            noteText += "Ended at : " + d.end;

            d3.select("#bubbleItemNote")
                    .text(noteText)
                    .attr("class", "wrapme");
            d3version4.selectAll('.wrapme').call(wrap);

        };

        window.onresize = resetBubbles(width);

    }
};



/******************************************************/
/* Bubble Chart                                       */
/*http://bl.ocks.org/phuonghuynh/54a2f97950feadb45b07 */
/******************************************************/

function drawBubbleChart(data) {

    // Call function to draw the Radar chart
    if (data.constructor === Object) {
        BubbleChartVis.draw(data);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error)
                throw error;
            BubbleChartVis.draw(data);
        });
    }
}

var BubbleChartVis = {
    draw: function (values) {

        var d3 = d3version3;

        var bubbleChart = new d3.svg.BubbleChart({
            supportResponsive: true,
            //container: => use @default
            size: 600,
            //viewBoxSize: => use @default
            innerRadius: 600 / 3.5,
            //outerRadius: => use @default
            radiusMin: 50,
            //radiusMax: use @default
            //intersectDelta: use @default
            //intersectInc: use @default
            //circleColor: use @default
            data: {
                items: values.items,
                eval: function (item) {
                    return item.count;
                },
                classed: function (item) {
                    return item.text.split(" ").join("");
                }
            },
            plugins: [
                {
                    name: "central-click",
                    options: {
                        text: "(Visualizar detalhes)",
                        style: {
                            "font-size": "20px",
                            "text-anchor": "middle",
                            "text-shadow": "0 0 0 black"

                        },
                        attr: {dy: "65px"},
                        centralClick: function (d) {
                            window.open("/" + window.location.pathname.split("/")[1] + d.link);
                        }
                    }
                },
                {
                    name: "lines",
                    options: {
                        format: [
                            {
                                textField: "count",
                                classed: {count: true},
                                style: {
                                    "font-size": "28px",
                                    "text-anchor": "middle",
                                    "text-shadow": "0 0 0 black"
                                },
                                attr: {
                                    dy: "0px",
                                    x: function (d) {
                                        return d.cx;
                                    },
                                    y: function (d) {
                                        return d.cy;
                                    }
                                }
                            },
                            {// Line #1
                                textField: "text",
                                classed: {text: true},
                                style: {
                                    "font-size": "14px",
                                    "text-anchor": "middle",
                                    "text-shadow": "0 0 0 black"
                                },
                                attr: {
                                    dy: "20px",
                                    x: function (d) {
                                        return d.cx;
                                    },
                                    y: function (d) {
                                        return d.cy;
                                    }
                                }
                            }
                        ],
                        centralFormat: [
                            {// Line #0
                                style: {
                                    "font-size": "50px",
                                    "text-shadow": "0 0 0 black"
                                },
                                attr: {}
                            },
                            {// Line #1
                                style: {
                                    "font-size": "30px",
                                    "text-shadow": "0 0 0 black"
                                },
                                attr: {dy: "40px"}
                            }
                        ]
                    }
                }]
        });
    }
};