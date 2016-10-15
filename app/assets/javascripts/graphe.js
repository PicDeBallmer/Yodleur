function graphe(selecteur){

  $.ajax({
    type: "GET",
    url: this.location + "/graphe.json",
    dataType: "json",
    success: function(donnees){
      dessiner(donnees);
    },
    error: function(erreur){
      console.warn("Impossible de contacter le serveur : " + erreur);
    }
  });

  var nodeWidth = 200,
      nodeHeight = 50;

  var svg = d3.select(selecteur)
    .append("svg")
    .attr("width", "100%")
    .attr("class", "graphe");

  function width(){ return $(svg[0]).width(); }
  function height(){ return $(svg[0]).height(); }

  var force = d3.layout.force()
    .charge(-100)
    .linkDistance(nodeWidth + nodeHeight) // approximation
    .size([width(), height() * 2]); // * 2 car il semble y avoir un bogue au chargement

  function dessiner(json){

    svg.attr("height", Math.sqrt(json.links.length * nodeHeight * 2500)); // approximation

    force
      .nodes(json.nodes)
      .links(json.links)
      .start();

    var links = svg.selectAll(".link")
      .data(json.links)
      .enter()
      .append("line")
      .attr("class", "link");

    var nodes = svg.selectAll(".node")
      .data(json.nodes)
      .enter()
      .append("g")
      .call(force.drag);

    nodes.append("rect")
      .attr("class", "node")
      .attr("height", nodeHeight)
      .attr("width", nodeWidth);

    // Magouille de l'espace pour pouvoir avoir des sauts de lignes automatiques en SVG. (pour plus de détails voir Aurélien)
    nodes.append("foreignObject")
      .attr("y", "5")
      .attr("x", "5")
      .attr("width", nodeWidth - 10)
      .attr("height", nodeHeight - 10)
      .append("xhtml:p")
      .attr("class", "node_desc")
      .attr("xmlns", "http://www.w3.org/1999/xhtml")
      .attr("title", function(d) { return d.description })
      .attr("data-id", function(d) { return d.id })
      .append("text")
      .text(function(d){ return d.titre })

    force.on("tick", function() {
      links.attr("x1", function(d) { return d.source.x + nodeWidth / 2; })
        .attr("y1", function(d) { return d.source.y + nodeHeight / 2; })
        .attr("x2", function(d) { return d.target.x + nodeWidth / 2; })
        .attr("y2", function(d) { return d.target.y + nodeHeight / 2; });

        nodes.attr("transform", function(d) {
          var nx = function(){
            nx = d.x;
            if(nx + nodeWidth > width()) nx = width() - nodeWidth;
            if(nx < 0) nx = 0;
            return nx;
          }();
          var ny = function(){
            ny = d.y;
            if(ny + nodeHeight > height()) ny = height() - nodeHeight;
            if(ny < 0) ny = 0;
            return ny;
          }();
  				return "translate(" + nx + "," + ny + ")";
  			});
    });

    $(".node_desc").click(function(){
      document.location = "/sujets/" + $(this).data("id");
    });

  }

  // Permet de recentrer le graphe lors du redimensionnement de la fenêtre
  $(window).resize(function() {
    force.size([width() / 2, height()]).resume();
  });

}
