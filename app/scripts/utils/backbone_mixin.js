define([], function(){
  return BackboneMixin = {
  _boundForceUpdate: function() {
    if (this.isMounted()) {
      this.forceUpdate();
    }
  },
  componentDidMount: function() {
    this.getBackboneObject().on("all", this._boundForceUpdate, this);
  },
  componentWillUnmount: function() {
    this.getBackboneObject().off("all", this._boundForceUpdate);
  },
  getBackboneObject: function() {
    return this.props.collection || this.props.model;
  }
}
})
