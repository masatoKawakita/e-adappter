define(["./core","./var/document","./var/documentElement","./var/isFunction","./var/rnothtmlwhite","./var/slice","./data/var/dataPriv","./core/nodeName","./core/init","./selector"],function(e,t,n,i,r,a,o,s){"use strict";function l(){return!0}function u(){return!1}function d(){try{return t.activeElement}catch(e){}}function c(t,n,i,r,a,o){var s,l;if("object"==typeof n){for(l in"string"!=typeof i&&(r=r||i,i=undefined),n)c(t,l,i,r,n[l],o);return t}if(null==r&&null==a?(a=i,r=i=undefined):null==a&&("string"==typeof i?(a=r,r=undefined):(a=r,r=i,i=undefined)),!1===a)a=u;else if(!a)return t;return 1===o&&(s=a,(a=function(t){return e().off(t),s.apply(this,arguments)}).guid=s.guid||(s.guid=e.guid++)),t.each(function(){e.event.add(this,n,a,r,i)})}var p=/^key/,h=/^(?:mouse|pointer|contextmenu|drag|drop)|click/,f=/^([^.]*)(?:\.(.+)|)/;return e.event={global:{},add:function(t,i,a,s,l){var u,d,c,p,h,g,v,m,y,b,E,T=o.get(t);if(T)for(a.handler&&(a=(u=a).handler,l=u.selector),l&&e.find.matchesSelector(n,l),a.guid||(a.guid=e.guid++),(p=T.events)||(p=T.events={}),(d=T.handle)||(d=T.handle=function(n){return void 0!==e&&e.event.triggered!==n.type?e.event.dispatch.apply(t,arguments):undefined}),h=(i=(i||"").match(r)||[""]).length;h--;)y=E=(c=f.exec(i[h])||[])[1],b=(c[2]||"").split(".").sort(),y&&(v=e.event.special[y]||{},y=(l?v.delegateType:v.bindType)||y,v=e.event.special[y]||{},g=e.extend({type:y,origType:E,data:s,handler:a,guid:a.guid,selector:l,needsContext:l&&e.expr.match.needsContext.test(l),namespace:b.join(".")},u),(m=p[y])||((m=p[y]=[]).delegateCount=0,v.setup&&!1!==v.setup.call(t,s,b,d)||t.addEventListener&&t.addEventListener(y,d)),v.add&&(v.add.call(t,g),g.handler.guid||(g.handler.guid=a.guid)),l?m.splice(m.delegateCount++,0,g):m.push(g),e.event.global[y]=!0)},remove:function(t,n,i,a,s){var l,u,d,c,p,h,g,v,m,y,b,E=o.hasData(t)&&o.get(t);if(E&&(c=E.events)){for(p=(n=(n||"").match(r)||[""]).length;p--;)if(m=b=(d=f.exec(n[p])||[])[1],y=(d[2]||"").split(".").sort(),m){for(g=e.event.special[m]||{},v=c[m=(a?g.delegateType:g.bindType)||m]||[],d=d[2]&&new RegExp("(^|\\.)"+y.join("\\.(?:.*\\.|)")+"(\\.|$)"),u=l=v.length;l--;)h=v[l],!s&&b!==h.origType||i&&i.guid!==h.guid||d&&!d.test(h.namespace)||a&&a!==h.selector&&("**"!==a||!h.selector)||(v.splice(l,1),h.selector&&v.delegateCount--,g.remove&&g.remove.call(t,h));u&&!v.length&&(g.teardown&&!1!==g.teardown.call(t,y,E.handle)||e.removeEvent(t,m,E.handle),delete c[m])}else for(m in c)e.event.remove(t,m+n[p],i,a,!0);e.isEmptyObject(c)&&o.remove(t,"handle events")}},dispatch:function(t){var n,i,r,a,s,l,u=e.event.fix(t),d=new Array(arguments.length),c=(o.get(this,"events")||{})[u.type]||[],p=e.event.special[u.type]||{};for(d[0]=u,n=1;n<arguments.length;n++)d[n]=arguments[n];if(u.delegateTarget=this,!p.preDispatch||!1!==p.preDispatch.call(this,u)){for(l=e.event.handlers.call(this,u,c),n=0;(a=l[n++])&&!u.isPropagationStopped();)for(u.currentTarget=a.elem,i=0;(s=a.handlers[i++])&&!u.isImmediatePropagationStopped();)u.rnamespace&&!u.rnamespace.test(s.namespace)||(u.handleObj=s,u.data=s.data,(r=((e.event.special[s.origType]||{}).handle||s.handler).apply(a.elem,d))!==undefined&&!1===(u.result=r)&&(u.preventDefault(),u.stopPropagation()));return p.postDispatch&&p.postDispatch.call(this,u),u.result}},handlers:function(t,n){var i,r,a,o,s,l=[],u=n.delegateCount,d=t.target;if(u&&d.nodeType&&!("click"===t.type&&t.button>=1))for(;d!==this;d=d.parentNode||this)if(1===d.nodeType&&("click"!==t.type||!0!==d.disabled)){for(o=[],s={},i=0;i<u;i++)s[a=(r=n[i]).selector+" "]===undefined&&(s[a]=r.needsContext?e(a,this).index(d)>-1:e.find(a,this,null,[d]).length),s[a]&&o.push(r);o.length&&l.push({elem:d,handlers:o})}return d=this,u<n.length&&l.push({elem:d,handlers:n.slice(u)}),l},addProp:function(t,n){Object.defineProperty(e.Event.prototype,t,{enumerable:!0,configurable:!0,get:i(n)?function(){if(this.originalEvent)return n(this.originalEvent)}:function(){if(this.originalEvent)return this.originalEvent[t]},set:function(e){Object.defineProperty(this,t,{enumerable:!0,configurable:!0,writable:!0,value:e})}})},fix:function(t){return t[e.expando]?t:new e.Event(t)},special:{load:{noBubble:!0},focus:{trigger:function(){if(this!==d()&&this.focus)return this.focus(),!1},delegateType:"focusin"},blur:{trigger:function(){if(this===d()&&this.blur)return this.blur(),!1},delegateType:"focusout"},click:{trigger:function(){if("checkbox"===this.type&&this.click&&s(this,"input"))return this.click(),!1},_default:function(e){return s(e.target,"a")}},beforeunload:{postDispatch:function(e){e.result!==undefined&&e.originalEvent&&(e.originalEvent.returnValue=e.result)}}}},e.removeEvent=function(e,t,n){e.removeEventListener&&e.removeEventListener(t,n)},e.Event=function(t,n){if(!(this instanceof e.Event))return new e.Event(t,n);t&&t.type?(this.originalEvent=t,this.type=t.type,this.isDefaultPrevented=t.defaultPrevented||t.defaultPrevented===undefined&&!1===t.returnValue?l:u,this.target=t.target&&3===t.target.nodeType?t.target.parentNode:t.target,this.currentTarget=t.currentTarget,this.relatedTarget=t.relatedTarget):this.type=t,n&&e.extend(this,n),this.timeStamp=t&&t.timeStamp||Date.now(),this[e.expando]=!0},e.Event.prototype={constructor:e.Event,isDefaultPrevented:u,isPropagationStopped:u,isImmediatePropagationStopped:u,isSimulated:!1,preventDefault:function(){var e=this.originalEvent;this.isDefaultPrevented=l,e&&!this.isSimulated&&e.preventDefault()},stopPropagation:function(){var e=this.originalEvent;this.isPropagationStopped=l,e&&!this.isSimulated&&e.stopPropagation()},stopImmediatePropagation:function(){var e=this.originalEvent;this.isImmediatePropagationStopped=l,e&&!this.isSimulated&&e.stopImmediatePropagation(),this.stopPropagation()}},e.each({altKey:!0,bubbles:!0,cancelable:!0,changedTouches:!0,ctrlKey:!0,detail:!0,eventPhase:!0,metaKey:!0,pageX:!0,pageY:!0,shiftKey:!0,view:!0,char:!0,charCode:!0,key:!0,keyCode:!0,button:!0,buttons:!0,clientX:!0,clientY:!0,offsetX:!0,offsetY:!0,pointerId:!0,pointerType:!0,screenX:!0,screenY:!0,targetTouches:!0,toElement:!0,touches:!0,which:function(e){var t=e.button;return null==e.which&&p.test(e.type)?null!=e.charCode?e.charCode:e.keyCode:!e.which&&t!==undefined&&h.test(e.type)?1&t?1:2&t?3:4&t?2:0:e.which}},e.event.addProp),e.each({mouseenter:"mouseover",mouseleave:"mouseout",pointerenter:"pointerover",pointerleave:"pointerout"},function(t,n){e.event.special[t]={delegateType:n,bindType:n,handle:function(t){var i,r=this,a=t.relatedTarget,o=t.handleObj;return a&&(a===r||e.contains(r,a))||(t.type=o.origType,i=o.handler.apply(this,arguments),t.type=n),i}}}),e.fn.extend({on:function(e,t,n,i){return c(this,e,t,n,i)},one:function(e,t,n,i){return c(this,e,t,n,i,1)},off:function(t,n,i){var r,a;if(t&&t.preventDefault&&t.handleObj)return r=t.handleObj,e(t.delegateTarget).off(r.namespace?r.origType+"."+r.namespace:r.origType,r.selector,r.handler),this;if("object"==typeof t){for(a in t)this.off(a,n,t[a]);return this}return!1!==n&&"function"!=typeof n||(i=n,n=undefined),!1===i&&(i=u),this.each(function(){e.event.remove(this,t,i,n)})}}),e});