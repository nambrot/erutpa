(function() {
  define(['jquery'], function($) {
    return function(callback) {
      return $(function() {
        var selection_object,
          _this = this;
        selection_object = null;
        $('body').on('mouseenter.erutpa', '.erutpa-learn-more-button', function() {
          var sel;
          sel = window.getSelection();
          sel.removeAllRanges();
          return sel.addRange(selection_object.modified_range);
        });
        $('body').on('mouseleave.erutpa', '.erutpa-learn-more-button', function() {
          var sel;
          sel = window.getSelection();
          sel.removeAllRanges();
          return sel.addRange(selection_object.original_range);
        });
        $('body').on('click.erutpa', '.erutpa-learn-more-button', function(evt) {
          var sel;
          sel = window.getSelection();
          callback(selection_object, evt);
          setTimeout((function() {
            sel = window.getSelection();
            sel.removeAllRanges();
            return sel.addRange(selection_object.modified_range);
          }), 100);
          return false;
        });
        return $('body').mouseup(function(evt) {
          var backwards, direction, endNode, endOffset, modified_range, modified_string, original_range, range, sel, span;
          if ($('.erutpa-learn-more-button-container').has(evt.target).length > 0) {
            return;
          }
          if (selection_object) {
            $('.erutpa-learn-more-button-container').remove();
            $('.erutpa-original-selection').contents().unwrap();
          }
          selection_object = null;
          if (window.getSelection && (sel = window.getSelection()).modify) {
            sel = window.getSelection();
            if (!sel.isCollapsed && sel.anchorNode.parentNode === sel.focusNode.parentNode) {
              range = document.createRange();
              range.setStart(sel.anchorNode, sel.anchorOffset);
              range.setEnd(sel.focusNode, sel.focusOffset);
              backwards = range.collapsed;
              range.detach();
              original_range = sel.getRangeAt(0);
              endNode = sel.focusNode;
              endOffset = sel.focusOffset;
              sel.collapse(sel.anchorNode, sel.anchorOffset);
              direction = backwards ? ['backward', 'forward'] : ['forward', 'backward'];
              sel.modify("move", direction[0], "character");
              sel.modify("move", direction[1], "word");
              sel.extend(endNode, endOffset);
              sel.modify("extend", direction[1], "character");
              sel.modify("extend", direction[0], "word");
              modified_range = sel.getRangeAt();
              modified_string = modified_range.toString();
              span = document.createElement('span');
              span.className = 'erutpa-original-selection';
              original_range.surroundContents(span);
              $("<span class='erutpa-learn-more-button-container'><span class='erutpa-learn-more-button'>Learn more</span></span>").insertAfter('.erutpa-original-selection');
              sel.removeAllRanges();
              sel.addRange(original_range);
              return selection_object = {
                original_range: original_range,
                modified_range: modified_range,
                modified_string: modified_string,
                backwards: true,
                span: span
              };
            }
          }
        });
      });
    };
  });

}).call(this);
