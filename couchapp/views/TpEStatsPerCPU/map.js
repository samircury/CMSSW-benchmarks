function(doc) {
  if (doc.AvgEventTime != undefined) {
    emit(doc.CPUModel, parseFloat(doc.AvgEventTime));
  }
}
