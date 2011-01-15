var Doc, DocCollection, DocController, IndexDocView, ShowDocView;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
}, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
this.app = {
  activePage: function() {
    return $(".ui-page-active");
  },
  reapplyStyles: function(el) {
    el.find('ul[data-role]').listview();
    el.find('div[data-role="fieldcontain"]').fieldcontain();
    el.find('button[data-role="button"]').button();
    el.find("[type='radio'], [type='checkbox']").checkboxradio();
    el.find("button, [type='button'], [type='submit'], [type='reset'], [type='image']").not(".ui-nojs").button();
    el.find("input, textarea").not("[type='search'], [type='radio'], [type='checkbox'], button, [type='button'], [type='submit'], [type='reset'], [type='image']").textinput();
    el.find("input, select").filter("[data-role='slider'], [data-type='range']").slider();
    el.find("select:not([data-role='slider'])").selectmenu();
    return el.page();
  },
  redirectTo: function(page) {
    return $.mobile.changePage(page);
  },
  goBack: function() {
    return $.historyBack();
  },
  "switch": function() {
    $('#nav a').not($(this)).removeClass('on');
    $(this).addClass('on');
    return console.log("Switch");
  }
};
Doc = (function() {
  function Doc() {
    Doc.__super__.constructor.apply(this, arguments);
  }
  __extends(Doc, Backbone.Model);
  Doc.prototype.getTitle = function() {
    return this.get('title');
  };
  Doc.prototype.getThumbnailUrl = function() {
    return this.get('cached_thumbnail');
  };
  Doc.prototype.getLatitude = function() {
    return this.get('geolat');
  };
  Doc.prototype.getLongitude = function() {
    return this.get('geolong');
  };
  Doc.prototype.getThumbnail = function() {
    if (this.get('cached_thumbnail')) {
      return "http://www.culturegrid.org.uk/" + this.get('cached_thumbnail');
    }
  };
  return Doc;
})();
DocCollection = (function() {
  function DocCollection() {
    DocCollection.__super__.constructor.apply(this, arguments);
  }
  __extends(DocCollection, Backbone.Collection);
  DocCollection.prototype.model = Doc;
  DocCollection.prototype.url = "http://culturegrid.heroku.com/search?q=happy&page=1&per_page=10";
  DocCollection.prototype.query = "";
  DocCollection.prototype.getByTerm = function(query) {
    var d;
    d = new DocCollection();
    d.url = "http://culturegrid.heroku.com/search?q=" + query + "&page=1&per_page=10";
    d.query = query;
    return d;
  };
  return DocCollection;
})();
DocController = (function() {
  __extends(DocController, Backbone.Controller);
  DocController.prototype.routes = {
    "docs": "index",
    "docs-:cid": "show",
    "search-:term": "search"
  };
  function DocController() {
    DocController.__super__.constructor.apply(this, arguments);
    this._views = {};
  }
  DocController.prototype.index = function() {
    var _base;
    return (_base = this._views)["docs"] || (_base["docs"] = new IndexDocView({
      docs: app.Docs
    }));
  };
  DocController.prototype.show = function(cid) {
    var _base, _name;
    return (_base = this._views)[_name = "docs-" + cid] || (_base[_name] = new ShowDocView({
      model: app.Docs.getByCid(cid)
    }));
  };
  DocController.prototype.search = function(term) {
    var _base, _name;
    return (_base = this._views)[_name = "search-" + term] || (_base[_name] = new IndexDocView({
      docs: app.Docs.getByTerm(term)
    }));
  };
  return DocController;
})();
IndexDocView = (function() {
  __extends(IndexDocView, Backbone.View);
  function IndexDocView() {
    this.render = __bind(this.render, this);;    IndexDocView.__super__.constructor.apply(this, arguments);
    this.el = app.activePage();
    this.template = _.template('<div>\n  \n  <form action="#docs" method="post" id="search">\n\n      <label>Find something:</label>\n      <input type="text" value="<%= query %>" name="q" id="q" />\n      <button type="submit" data-role="button">Search</button>\n                \n  </form>\n\n <ul data-role="listview" data-inset="true">\n    <% docs.each(function(doc){ %>\n    <li><a href="#docs-<%= doc.cid %>"><%= doc.getTitle() %></a>\n    <% if(doc.getThumbnail() != "") { %>\n    <img src="<%= doc.getThumbnail() %>" />\n    <% } %>\n    </li>\n    <% }); %>\n </ul>\n\n</div>');
    app.Docs.bind('add', this.render);
    app.Docs.fetch({
      success: this.render
    });
    this.render();
  }
  IndexDocView.prototype.events = {
    "submit form": "onSubmit"
  };
  IndexDocView.prototype.onSubmit = function(e) {
    console.log("submit");
    app.Docs = app.Docs.getByTerm($('#q').val());
    app.Docs.fetch({
      success: this.render
    });
    e.preventDefault();
    return e.stopPropagation();
  };
  IndexDocView.prototype.render = function() {
    $('#search').submit(this.onSubmit);
    console.log(app.Docs.query);
    this.el.find('.ui-content').html(this.template({
      docs: app.Docs,
      query: app.Docs.query
    }));
    app.Docs.invoke("bind", 'change', this.render);
    app.reapplyStyles(this.el);
    return this.delegateEvents();
  };
  return IndexDocView;
})();
ShowDocView = (function() {
  __extends(ShowDocView, Backbone.View);
  function ShowDocView() {
    this.render = __bind(this.render, this);;    ShowDocView.__super__.constructor.apply(this, arguments);
    this.el = app.activePage();
    this.template = _.template('<div>\n  \n  <p>\n    <img style="width: 100%" src="<%= doc.getThumbnail() %>" />\n  </p>\n \n</div>');
    this.model.bind('change', this.render);
    this.render();
  }
  ShowDocView.prototype.render = function() {
    this.el.find('h1').text(this.model.getTitle());
    this.el.find('.ui-content').html(this.template({
      doc: this.model
    }));
    return app.reapplyStyles(this.el);
  };
  return ShowDocView;
})();
app.Docs = new DocCollection().getByTerm("soon");
app.docController = new DocController();
$(document).ready(function() {
  Backbone.history.start();
  return app.docController.index();
});
this.app = app;