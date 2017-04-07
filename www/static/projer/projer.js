var Projer = function(_div)
  {
  var div = _div;
  var self = this;
  var data_source = "/riak/buckets/projer/keys/projer"
  self.current = "0";   
  var state = "templates/main.html";
  this.filter_template = function(template)
    {
    var z = JSON.parse(templates.replace(/\n/g, ""));
    _.each(z, function(value, key){self.templates[key] = _.template(value)})
    }
  this.push = function()
    {
    $.ajax({
      url: data_source,
      data: JSON.stringify(this.data),
      type: "PUT",
      contentType: "application/json"});
    }
  this.refresh = function()
    {
    div.html(self.templates[state]({self: self, rows: self.data}));
    $(".row").click(function(f){
      self.current = ($(f.currentTarget).attr("data"));
      state = "templates/edit.html";
      self.refresh();
      })
    $(".back").click(function(f){
      state = "templates/main.html";
      self.refresh();
      })
    $(".up").click(function(f){
      up = Number($(f.currentTarget).attr("data"));
      down = up - 1;
      if(down >= 0) {
        tmp = self.data[down];
        self.data[down] = self.data[up];
        self.data[up] = tmp;
        self.refresh();
        self.push();
        }
    })
    $(".down").click(function(f){
      down = Number($(f.currentTarget).attr("data"));
      up = down + 1;
      if(up < self.data.length) {
        tmp = self.data[down];
        self.data[down] = self.data[up];
        self.data[up] = tmp;
        self.refresh();
        self.push();
        }
      return false;
      })
    $(".add").click(function(f){
      var add = self.data.length;
      self.current = add;
      self.data[add] = {text:""};
      state = "templates/edit.html";
      self.refresh();
      })
    $(".update").blur(function(f){
      _.each($(f.currentTarget), function(e){
        self.data[self.current][e.name] = e.value
        });
      self.push();
      })
    }
  CR.getAll([
    "templates/main.html",
    "templates/edit.html",
    data_source
  ], function(i){
       var regex = /templates\//
       function filter(key, value) 
         {
         return regex.test(key);
         }
       var parts = CR.hashPartition(i, filter);
       self.templates = CR.hashMap(parts[0], CR.I, _.template);
       self.data = CR.darkenJSON(parts[1][data_source]);
       self.refresh();
     });
  }

