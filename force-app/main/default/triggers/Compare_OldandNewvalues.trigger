trigger Compare_OldandNewvalues on Account (before update) {
    
    CompareOldVsNewValues.main(trigger.new);

}