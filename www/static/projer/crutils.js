var CR = 
{
  I : function(x){ return x },
  getAll : function(urls, callback)
    {
    var i = urls.length;
    var index = {};
    _.map(urls, function(u)
      {
      $.get(u, null, null, "text").done(function(v){
        i = i-1;
        index[u] = v; 
        if(i == 0) {callback(index);}
        }).fail(function(v){i = i-1; if(i == 0) {callback(index)} } );
      })
    },
  darkenJSON : function(j)
    {
    return JSON.parse(j.replace(/\n/g, ""));
    },
  hashMap : function(hash, keymap, valuemap)
    {
    return _.object(
             _.map(
               _.pairs(hash),
               function(h){return [
                 keymap(h[0]), 
                 valuemap(h[1]) ]}
               )
             )
    },
  hashPartition : function(hash, predicate)
    {
    var parts =  
      _.partition(
        _.pairs(hash), 
        function(p){return predicate(p[0],p[1])}
        );
      return [_.object(parts[0]), _.object(parts[1])]
    }
};

