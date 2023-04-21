<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.footer.icon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>

  {% if theme.post_wordcount.totalcount %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.post_wordcount.item_text %}
      <span class="post-meta-item-text">{{ __('post.totalcount') }}&#58;</span>
    {% endif %}
    <span title="{{ __('post.totalcount') }}">{#
    #}{{ totalcount(site, '0,0.0a') }}{#
  #}</span>
  {% endif %}
  <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAATCAYAAACdkl3yAAAEX0lEQVR42m2TWWyUBRSFv3+dfzprpxstgVIKpQitFgqYAhIRNJGwSPRBUHnAuAXjEknUUI34osYYHyCE6IOIIIoGicEm7Js1haJUbCltoYWWtrSdmc60s/y7L6QR9b6dh/vdk5xzZf5nLp/dW5ETVNf4uPIYjjBdVHRXlLXrI8mpp32h4l+mVa5q+feO/E8xHj87OTHQXK+PtT8jiaJPN/2oWhm6mQZ7oNznyz5qJjrre698vSNSXPqRL39Z7D+gxNDxmmTP9wd0x6oQ3BKkhm60c9cRBRNZdDBFBXPxTKTFVV7o3poaal6TiB5/OpS34o8JUG/Pscpo1+GDgpQtV/uyaNt3kdMygFMsodeGUD0CwcYk7qHzjM4rw3h/A0Jl0azEzdZd3Z0n15fNXN4vA9jJy9tse6Dc32/if/0c2lACUZGIBRViK8NIhQUUdbSSMwSFbX0ktuwm9cUWxEmpRYLR9wqwTR6Pnq4ead/7lKZF8Hx8FCk5xp23ZhA6HiXUFsM+F8P2gdplk1yaR2ZJAZFP2jA+2If05WYMs3tLMtq4VzbHLq7zF6ZUo0nA39wLGnguxnCHLOxgmMgPSVw1hRNWEfoyKBdiyK5A7oUuRjp6CdQUhaxU5wbZzCQWGYaGfPEWkmsjZCD/2DDpYo1kfS3eXV0QsdA3FeCv7yPYcBsACVCuDmJV52Cke+fLY/FMGWKQnGgS4W6CLiAnDdTvWvF0xHElgAxiPHNPb8SW2xjrHySbiBbKak7AowTiyJHAPQWz76tEnD4Hs9RBEGxcWcEZaELouIV795iSp2EoEqI8JSjH78QGS/z6dGumH+eu5YziIfbOk6jz5yE5Mkgyrscke7gQ5YWdSIAFZB+IIGWvYaWCN2VPqOw0xp91zjyZ9Ku1eH0hzLAPuTyOMH4MQVBxBQM360Gq8WC+txZbd0nHU4hzfWANEiisOSqrvhkHx2KXtub4vYr99gr0lIjs6GhjBiTSSK6FI1jYqoHkzcPeWI2j+TFtCyPWjZ7MHcsvn3VILqtafbn1VP1+qbF1k1Q7gtgcRfn0V7S4iRtRsOqKEfqTeK8lEEd1rFIf+pt1OGVB3H4X5f4lu8MlD9+QASYVLv3QennfarXIiVifr8XdUYK6/zz28nyclTUIroSz8zx2+zDmG3NxXRXvayegtPSab/mLn038mhKzRtThhJttj6KsO4D9Uh3jj09B7hhD2t6ELcnoVUU4CyNoP/chHriBfnsEn6d4IFCyZGACZF5qmeOJRvNkwEolUb79DSc/BNWTEBeEIJVFONuJp2cUIW2QHU7gBdzu7prMmZ+C3mXrkjLAYN7UvvFly/ZUnDmzSZvsp+f5J8htuo7rWmgzwjCcQfBmGV1YgT47xLR39xF3FKNrwfxvYo2/2xOO5jy78VbbkYbNR0aiVz1DQ1X+dvGUffLqc4FEsqCn4WZ/OGuEc/uH88Znz/6rNT33RL8n8Ii0dtVXD+3Z8yMNRwH4G+Nk9O/mybiiAAAAAElFTkSuQmCC" style="display: inline-block">
  <a href="https://beian.miit.gov.cn/"  style="color:#f72b07" target="_blank">京ICP备18018172号</a>
</div>

{% if theme.footer.powered %}
  <div class="powered-by">{#
  #}{{ __('footer.powered', '<a class="theme-link" target="_blank" href="https://hexo.io">Hexo</a>') }}{#
#}</div>
{% endif %}

{% if theme.footer.powered and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{% endif %}

{% if theme.footer.theme.enable %}
  <div class="theme-info">{#
  #}{{ __('footer.theme') }} &mdash; {#
  #}<a class="theme-link" target="_blank" href="https://github.com/iissnan/hexo-theme-next">{#
    #}NexT.{{ theme.scheme }}{#
  #}</a>{% if theme.footer.theme.version %} v{{ theme.version }}{% endif %}{#
#}</div>
{% endif %}

{% if theme.footer.custom_text %}
  <div class="footer-custom">{#
  #}{{ theme.footer.custom_text }}{#
#}</div>
{% endif %}
