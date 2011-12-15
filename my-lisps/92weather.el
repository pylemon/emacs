;; 功能:
;; 使用命令在minibuffer中查询当前设置的城市的天气情况


(require 'cn-weather)

;; 设置命令别名
(defalias 'weather 'cn-weather-today)
(defalias 'weather-tomorrow 'cn-weather-forecast)

;; 设置需要查询的城市
(setq cn-weather-city "上海")

;; 启动时读取一次，下次查询时不会出现nil
;(cn-weather)
