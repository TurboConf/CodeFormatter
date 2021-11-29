
#Область ПрограммныйИнтерфейс

Процедура ФорматироватьМодуль(ТекстМодуля, ПараметрыФорматирования) Экспорт
	
	ОбработатьТекст(ТекстМодуля, ПараметрыФорматирования);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбработатьТекст(ТекстМодуля, ПараметрыФорматирования)
	
	ТаблицаМодуля = СтруктураТаблицыМодуля();
	ПравилаОтступов = ПравилаОтступов();
	
	ЗагрузитьМодульВТаблицуПреобразований(ТаблицаМодуля, ТекстМодуля);

	УстановитьОтступы(ТаблицаМодуля, ПравилаОтступов, ПараметрыФорматирования);
	УстановитьСдвиги(ТаблицаМодуля, ПараметрыФорматирования);
	
	УстановитьПробелыДляМатематическихОператоров(ТаблицаМодуля, ПараметрыФорматирования);
	ПривестиККаноническомуНаписанию(ТаблицаМодуля, ПараметрыФорматирования);
	
	ТекстМодуля = НовыйТекстМодуля(ТаблицаМодуля);
	
КонецПроцедуры

Процедура ЗагрузитьМодульВТаблицуПреобразований(ТаблицаМодуля, ТекстМодуля)
	
	МассивСтрокМодуля = СтрРазделить(ТекстМодуля, Символы.ПС, Истина);
	
	Для каждого Стр Из МассивСтрокМодуля Цикл
		
		ДанныеСтроки = СтруктураСтрокиМодуля(Стр);
		
		СтрокаМодуля = ТаблицаМодуля.Добавить();
		СтрокаМодуля.Текст = СокрЛП(ДанныеСтроки.СтрокаМодуля);
		СтрокаМодуля.Комментарий = СокрЛП(ДанныеСтроки.Комментарий);
		СтрокаМодуля.Уровень = 0;
		СтрокаМодуля.ДопУровень = 0;
		СтрокаМодуля.СдвигатьВперед = Ложь;
		СтрокаМодуля.СдвигатьНазад = Ложь;
		СтрокаМодуля.ШагНазад = Ложь;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура УстановитьОтступы(ТаблицаМодуля, Правила, ПараметрыФорматирования)
	
	Если НЕ ПараметрыФорматирования.УстанавливатьОтступы Тогда
		
		Возврат;

	КонецЕсли;

	Методы = Новый Массив;
	Методы.Добавить("Процедура");
	Методы.Добавить("Функция");
	Методы.Добавить("КонецПроцедуры");
	Методы.Добавить("КонецФункции");
	
	Условия = Новый Массив;
	Условия.Добавить("Если");
	Условия.Добавить("#Если");
	Условия.Добавить("ИначеЕсли");
	Условия.Добавить("#ИначеЕсли");
	Условия.Добавить("Иначе");
	Условия.Добавить("#Иначе");
	Условия.Добавить("КонецЕсли");
	Условия.Добавить("#КонецЕсли");
	Условия.Добавить("И(.*)Тогда");
	
	Циклы = Новый Массив;
	Циклы.Добавить("Для");
	Циклы.Добавить("Пока");
	Циклы.Добавить("КонецЦикла");
	Циклы.Добавить("Прервать");
	Циклы.Добавить("Продолжить");
	
	Попытки = Новый Массив;
	Попытки.Добавить("Попытка");
	Попытки.Добавить("Исключение");
	Попытки.Добавить("КонецПопытки");
	
	Возвраты = Новый Массив;
	Возвраты.Добавить("Возврат");

	Препроцессоры = Новый Массив;
	Препроцессоры.Добавить("&");

	ПредыдущаяСтрока = Неопределено;
	А = 0;
	
	Пока А < ТаблицаМодуля.Количество() Цикл
		
		СтрокаМодуля = ТаблицаМодуля[А];
		СледующаяСтрока = СледующаяСтрокаМодуля(ТаблицаМодуля, А);

		Если ОтноситсяКБлоку(СтрокаМодуля, Препроцессоры) Тогда
			ОбработатьПравилоПустойСтрокиПосле(СтрокаМодуля, А, Правила.Метод, СледующаяСтрока, ТаблицаМодуля);
		КонецЕсли;

		Если ОтноситсяКБлоку(СтрокаМодуля, Методы) Тогда
			
			ОбработатьПравилоПустойСтрокиДо(СтрокаМодуля, А, Правила.Метод, ПредыдущаяСтрока, ТаблицаМодуля);
			ОбработатьПравилоПустойСтрокиПосле(СтрокаМодуля, А, Правила.Метод, СледующаяСтрока, ТаблицаМодуля);
			
		КонецЕсли;
		
		Если ОтноситсяКБлоку(СтрокаМодуля, Условия) Тогда
			
			ОбработатьПравилоПустойСтрокиДо(СтрокаМодуля, А, Правила.Условие, ПредыдущаяСтрока, ТаблицаМодуля);
			ОбработатьПравилоПустойСтрокиПосле(СтрокаМодуля, А, Правила.Условие, СледующаяСтрока, ТаблицаМодуля);
			
		КонецЕсли;
		
		Если ОтноситсяКБлоку(СтрокаМодуля, Циклы) Тогда
			
			ОбработатьПравилоПустойСтрокиДо(СтрокаМодуля, А, Правила.Цикл, ПредыдущаяСтрока, ТаблицаМодуля);
			ОбработатьПравилоПустойСтрокиПосле(СтрокаМодуля, А, Правила.Цикл, СледующаяСтрока, ТаблицаМодуля);
			
		КонецЕсли;
		
		Если ОтноситсяКБлоку(СтрокаМодуля, Попытки) Тогда
			
			ОбработатьПравилоПустойСтрокиДо(СтрокаМодуля, А, Правила.Попытка, ПредыдущаяСтрока, ТаблицаМодуля);
			ОбработатьПравилоПустойСтрокиПосле(СтрокаМодуля, А, Правила.Попытка, СледующаяСтрока, ТаблицаМодуля);
			
		КонецЕсли;
		
		Если ОтноситсяКБлоку(СтрокаМодуля, Возвраты) Тогда
			
			ОбработатьПравилоПустойСтрокиДо(СтрокаМодуля, А, Правила.Возврат, ПредыдущаяСтрока, ТаблицаМодуля);
			ОбработатьПравилоПустойСтрокиПосле(СтрокаМодуля, А, Правила.Возврат, СледующаяСтрока, ТаблицаМодуля);
			
		КонецЕсли;
		
		ПредыдущаяСтрока = СтрокаМодуля;
		
		А = А + 1;
		
	КонецЦикла;
	
	А = 0;
	ПредыдущаяСтрока = Неопределено;
	Пока А < ТаблицаМодуля.Количество() Цикл
		
		СтрокаМодуля = ТаблицаМодуля[А];
		
		Если (ПредыдущаяСтрока <> Неопределено)
			И (СокрЛП(СтрокаМодуля.Текст) = "" И СокрЛП(СтрокаМодуля.Комментарий) = "")
			И (СокрЛП(ПредыдущаяСтрока.Текст) = "" и СокрЛП(ПредыдущаяСтрока.Комментарий) = "") Тогда
			
			ТаблицаМодуля.Удалить(ПредыдущаяСтрока);
			А = А - 1;
			
		КонецЕсли;
		
		ПредыдущаяСтрока = СтрокаМодуля;
		А = А + 1;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьПравилоПустойСтрокиПосле(СтрокаМодуля, А, Правило, СледующаяСтрока, ТаблицаМодуля)
	
	ЗапретПустыхСтрокПеред = Новый Массив;
	ЗапретПустыхСтрокПеред.Добавить("И");
	ЗапретПустыхСтрокПеред.Добавить("ИЛИ");
	
	ЗапретПустойСтрокиПосле = Новый Массив();
	ЗапретПустойСтрокиПосле.Добавить("&");

	А = ТаблицаМодуля.Индекс(СтрокаМодуля);
	
	Если Правило.ПустаяСтрокаПосле Тогда
		
		Если ОтноситсяКБлоку(СтрокаМодуля, ЗапретПустойСтрокиПосле) Тогда

			Пока СокрЛП(СледующаяСтрока.Текст) = "" Цикл
				
				ТаблицаМодуля.Удалить(СледующаяСтрока);

				СледующаяСтрока = СледующаяСтрокаМодуля(ТаблицаМодуля, А);

			КонецЦикла;

		Иначе

			Если СледующаяСтрока = Неопределено Тогда
				
				НоваяСтрокаМодуля(ТаблицаМодуля, А + 1, "");
				
			ИначеЕсли СокрЛП(СледующаяСтрока.Текст) = "" Тогда
				// Ничего не далаем
			Иначе
				Если НЕ ОтноситсяКБлоку(СледующаяСтрока, ЗапретПустыхСтрокПеред) Тогда
					
					НоваяСтрокаМодуля(ТаблицаМодуля, А + 1, "");
					
				КонецЕсли;
				
			КонецЕсли;

		КонецЕсли;
		
	Иначе
		
		Если СокрЛП(СледующаяСтрока.Текст) = "" Тогда
			
			ТаблицаМодуля.Удалить(СледующаяСтрока);
			
		КонецЕсли;
		
	КонецЕсли;
	
	А = ТаблицаМодуля.Индекс(СтрокаМодуля);
	
КонецПроцедуры

Процедура ОбработатьПравилоПустойСтрокиДо(СтрокаМодуля, А, Правило, ПредыдущаяСтрока, ТаблицаМодуля)
	
	ДопустимыеСтрокиБезУстановкиПустойСтроки = Новый Массив;
	ДопустимыеСтрокиБезУстановкиПустойСтроки.Добавить("//");
	ДопустимыеСтрокиБезУстановкиПустойСтроки.Добавить("И");
	ДопустимыеСтрокиБезУстановкиПустойСтроки.Добавить("ИЛИ");
	
	ЗапретПустойСтрокиПосле = Новый Массив();
	ЗапретПустойСтрокиПосле.Добавить("&");

	А = ТаблицаМодуля.Индекс(СтрокаМодуля);
	
	Если Правило.ПустаяСтрокаДо Тогда

		Если ПредыдущаяСтрока = Неопределено Тогда
			
			НоваяСтрокаМодуля(ТаблицаМодуля, 0, "");
			
		ИначеЕсли СокрЛП(ПредыдущаяСтрока.Текст) = "" Тогда
			// Ничего не далаем
		Иначе

			Если НЕ ОтноситсяКБлоку(ПредыдущаяСтрока, ЗапретПустойСтрокиПосле) Тогда

				Если (НЕ ОтноситсяКБлоку(ПредыдущаяСтрока, ДопустимыеСтрокиБезУстановкиПустойСтроки)
					И НЕ ОтноситсяКБлоку(СтрокаМодуля, ДопустимыеСтрокиБезУстановкиПустойСтроки)) Тогда
					
					НоваяСтрокаМодуля(ТаблицаМодуля, А, "");
					
				КонецЕсли;

			КонецЕсли;
			
		КонецЕсли;
		
	Иначе
		
		Если СокрЛП(ПредыдущаяСтрока.Текст) = "" Тогда
			
			ТаблицаМодуля.Удалить(ПредыдущаяСтрока);
			
		КонецЕсли;
		
	КонецЕсли;
	
	А = ТаблицаМодуля.Индекс(СтрокаМодуля);
	
КонецПроцедуры

Процедура УстановитьСдвиги(ТаблицаМодуля, ПараметрыФорматирования)
	
	Если НЕ ПараметрыФорматирования.УстанавливатьСдвиги Тогда
		
		Возврат;

	КонецЕсли;

	МетодыВсегдаНулевойУровень = Истина;

	ВыраженияНулевогоУровня = Новый Массив;
	ВыраженияНулевогоУровня.Добавить("Процедура");
	ВыраженияНулевогоУровня.Добавить("Функция");
	ВыраженияНулевогоУровня.Добавить("КонецПроцедуры");
	ВыраженияНулевогоУровня.Добавить("КонецФункции");
	
	ТекстДляСдвига = Новый Массив;
	ТекстДляСдвига.Добавить("\+");
	ТекстДляСдвига.Добавить("-");
	ТекстДляСдвига.Добавить("\/");
	ТекстДляСдвига.Добавить("\*");
	ТекстДляСдвига.Добавить("\?");
	ТекстДляСдвига.Добавить(",");
	
	// Для корректного сдвига текста игнорируем комментарии
	ИгнорироватьСдвигДляТекста = Новый Массив;
	ИгнорироватьСдвигДляТекста.Добавить("\/\/");
	
	СдвигПосле = Новый Массив();
	СдвигПосле.Добавить("Процедура");
	СдвигПосле.Добавить("Функция");
	СдвигПосле.Добавить("Для");
	СдвигПосле.Добавить("Пока");
	СдвигПосле.Добавить("Если");
	СдвигПосле.Добавить("ИначеЕсли");
	СдвигПосле.Добавить("Иначе");
	СдвигПосле.Добавить("Попытка");
	СдвигПосле.Добавить("Исключение");
	
	СдвигПосле.Добавить("#Если");
	СдвигПосле.Добавить("#ИначеЕсли");
	СдвигПосле.Добавить("#Иначе");
	
	СдвигОбратно = Новый Массив;
	СдвигОбратно.Добавить("КонецПроцедуры");
	СдвигОбратно.Добавить("КонецФункции");
	СдвигОбратно.Добавить("КонецПопытки");
	
	СдвигОбратно.Добавить("КонецЕсли");
	СдвигОбратно.Добавить("КонецЦикла");
	
	СдвигОбратно.Добавить("#КонецЕсли");
	СдвигОбратно.Добавить("#КонецЦикла");
	
	ШагНазад = Новый Массив;
	ШагНазад.Добавить("Исключение");
	ШагНазад.Добавить("ИначеЕсли");
	ШагНазад.Добавить("Иначе");
	ШагНазад.Добавить("#ИначеЕсли");
	ШагНазад.Добавить("#Иначе");
	
	ПредыдущаяСтрока = Неопределено;
	НачалоПереноса = Ложь;
	ОбрабатыватьПереносСтроки = Истина;
	
	Для каждого СтрокаМодуля Из ТаблицаМодуля Цикл
		
		Если ОтноситсяКБлоку(СтрокаМодуля, СдвигПосле) Тогда
			
			СтрокаМодуля.СдвигатьВперед = Истина;
			СтрокаМодуля.СдвигатьНазад = Ложь;
			
			ОбрабатыватьПереносСтроки = Ложь;
		
		КонецЕсли;
		
		Если ОтноситсяКБлоку(СтрокаМодуля, СдвигОбратно) Тогда
			
			СтрокаМодуля.СдвигатьВперед = Ложь;
			СтрокаМодуля.СдвигатьНазад = Истина;
			
			ОбрабатыватьПереносСтроки = Ложь;
			
		КонецЕсли;
		
		Если ОтноситсяКБлоку(СтрокаМодуля, ШагНазад) Тогда
			
			СтрокаМодуля.ШагНазад = Истина;
			
			ОбрабатыватьПереносСтроки = Ложь;
			
		КонецЕсли;
		
		Если ПредыдущаяСтрока <> Неопределено 
			И Прав(ПредыдущаяСтрока.Текст, 1) = ","
			И Лев(ПредыдущаяСтрока.Текст, 1) <> "|"  Тогда

			СтрокаМодуля.СтрокаОткрыта = Истина;

		КонецЕсли;
		
		Если Прав(СтрокаМодуля.Текст, 1) = ";" И ОбрабатыватьПереносСтроки Тогда

			СтрокаМодуля.СтрокаОткрыта = Ложь;

		КонецЕсли;
		
		ПредыдущаяСтрока = СтрокаМодуля;
		
	КонецЦикла;
	
	ПредыдущаяСтрока = Неопределено;
	Для каждого СтрокаМодуля Из ТаблицаМодуля Цикл
		
		Если ПредыдущаяСтрока <> Неопределено Тогда
			
			Если ПредыдущаяСтрока.ШагНазад Тогда
				
				ПредыдущаяСтрока.Уровень = ПредыдущаяСтрока.Уровень - 1;
				
			КонецЕсли;
			
			СтрокаМодуля.Уровень = ПредыдущаяСтрока.Уровень
				+ ?(ПредыдущаяСтрока.СдвигатьВперед, 1, 0)
				+ ?(ПредыдущаяСтрока.СдвигатьНазад, -1, 0);
			
			Если ПредыдущаяСтрока.СдвигатьНазад Тогда
				
				ПредыдущаяСтрока.Уровень = ПредыдущаяСтрока.Уровень - 1;
				
			КонецЕсли;
			
			Если ОтноситсяКБлоку(СтрокаМодуля, ТекстДляСдвига)
				И НЕ ОтноситсяКБлоку(СтрокаМодуля, ИгнорироватьСдвигДляТекста) Тогда
				
				СтрокаМодуля.ДопУровень = 1;
				
			КонецЕсли;
			
			Если ПредыдущаяСтрока.СтрокаОткрыта Тогда
				
				ПредыдущаяСтрока.ДопУровень = ПредыдущаяСтрока.ДопУровень + 1;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если МетодыВсегдаНулевойУровень 
			И ОтноситсяКБлоку(СтрокаМодуля, ВыраженияНулевогоУровня) Тогда
			
			СтрокаМодуля.Уровень = 0;
			
		КонецЕсли;
		
		ПредыдущаяСтрока = СтрокаМодуля;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура УстановитьПробелыДляМатематическихОператоров(ТаблицаМодуля, ПараметрыФорматирования)
	
	Если НЕ ПараметрыФорматирования.УстановливатьПробелыДляМатематическихОператоров Тогда
		
		Возврат;

	КонецЕсли;

	ТегиОператоров = Новый Соответствие();
	ТегиОператоров.Вставить("<>", "{{{НеРавно}}}");
	ТегиОператоров.Вставить(">=", "{{{БольшеИлиРавно}}}");
	ТегиОператоров.Вставить("<=", "{{{МеньшеИлиРавно}}}");
	ТегиОператоров.Вставить(">", "{{{Больше}}}");
	ТегиОператоров.Вставить("<", "{{{Меньше}}}");
	ТегиОператоров.Вставить("=", "{{{Равно}}}");
	ТегиОператоров.Вставить("+", "{{{Плюс}}}");
	ТегиОператоров.Вставить("-", "{{{Минус}}}");
	ТегиОператоров.Вставить("*", "{{{Умножение}}}");
	ТегиОператоров.Вставить("/", "{{{Деление}}}");
	
	СтрокаОткрыта = Ложь;
	ОбластьОткрыта = Ложь;
	
	Для каждого СтрокаТабилцыМодуля Из ТаблицаМодуля Цикл
		
		ИзмененнаяСтрокаМодуля = СтрокаТабилцыМодуля.Текст;
		
		Если ПустаяСтрока(ИзмененнаяСтрокаМодуля) Тогда // Строка пустая
			Продолжить;
		КонецЕсли;

		Если Лев(ИзмененнаяСтрокаМодуля, 1) = "|" Тогда
			Продолжить;
		КонецЕсли;
		
		ТекстВыражения = """[^""]*(?:""""[^""]*)*(""|$)";
		РегВыражение = Новый РегулярноеВыражение(ТекстВыражения);
		
		Совпадения = РегВыражение.НайтиСовпадения(ИзмененнаяСтрокаМодуля);
		
		ЗаменыКавычек = Новый Соответствие();

		Если Совпадения.Количество() > 0 Тогда
			
			НомерКавычек = 0;
			Для Каждого Совпадение Из Совпадения Цикл
				
				НомерКавычек = НомерКавычек + 1;

				СтрокаВКавычках = Совпадение.Группы[0].Значение;

				КлючКавычек = "{{{НомерКавычек" + НомерКавычек + "}}}";
				ЗаменыКавычек.Вставить(КлючКавычек, СтрокаВКавычках);

				ИзмененнаяСтрокаМодуля = СтрЗаменить(ИзмененнаяСтрокаМодуля, СтрокаВКавычках, КлючКавычек);
				
			КонецЦикла;
			
		КонецЕсли;
		
		Для каждого Тег Из ТегиОператоров Цикл
			
			ИзмененнаяСтрокаМодуля = СтрЗаменить(ИзмененнаяСтрокаМодуля, Тег.Ключ, Тег.Значение);
			
		КонецЦикла;

		РегВыражение = Новый РегулярноеВыражение(",(\S+)");
		ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, ", $1");

		РегВыражение = Новый РегулярноеВыражение("\s+,");
		ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, ",");
		
		РегВыражение = Новый РегулярноеВыражение("\s*(\()\s*");
		ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, "$1");

		РегВыражение = Новый РегулярноеВыражение("\s+\)");
		ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, ")");

		РегВыражение = Новый РегулярноеВыражение("\)\s*;");
		ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, ");");
		
		Для каждого Тег Из ТегиОператоров Цикл
			
			РегВыражение = Новый РегулярноеВыражение("(\S+)(" + Тег.Значение + ")(\S+)");
			ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, "$1 $2 $3");
			
			РегВыражение = Новый РегулярноеВыражение("(\S+)(" + Тег.Значение + "\S+)");
			ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, "$1 $2");
			
			РегВыражение = Новый РегулярноеВыражение("(\S+)(" + Тег.Значение + "\s+)");
			ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, "$1 $2");
			
			РегВыражение = Новый РегулярноеВыражение("(\s+)((" + Тег.Значение + ")(\S+))");
			ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, " $3 $4");

		КонецЦикла;
		
		Для каждого Тег Из ТегиОператоров Цикл
			
			ИзмененнаяСтрокаМодуля = СтрЗаменить(ИзмененнаяСтрокаМодуля, Тег.Значение, Тег.Ключ);
			
		КонецЦикла;
		
		Для каждого КлючЗначениеКавычек Из ЗаменыКавычек Цикл

			ИзмененнаяСтрокаМодуля = СтрЗаменить(ИзмененнаяСтрокаМодуля, 
				КлючЗначениеКавычек.Ключ, 
				КлючЗначениеКавычек.Значение);

		КонецЦикла;

		СтрокаТабилцыМодуля.Текст = ИзмененнаяСтрокаМодуля;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ДобавитьСдвиги(ИсходнаяСтрока, Количество, ТипСдвигов = "Таб")
	
	Сдвиги = "";
	
	Для А = 0 По Количество - 1 Цикл
		
		Если ТипСдвигов = "Таб" Тогда
			
			Сдвиги = Сдвиги + Символы.Таб;
			
		Иначе
			
			Сдвиги = Сдвиги + " ";
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Сдвиги + ИсходнаяСтрока;
	
КонецФункции

Функция СтруктураТаблицыМодуля()
	
	ТаблицаМодуля = Новый ТаблицаЗначений();
	ТаблицаМодуля.Колонки.Добавить("Текст", Новый ОписаниеТипов("Строка"));
	ТаблицаМодуля.Колонки.Добавить("Комментарий", Новый ОписаниеТипов("Строка"));
	ТаблицаМодуля.Колонки.Добавить("Уровень", Новый ОписаниеТипов("Число"));
	ТаблицаМодуля.Колонки.Добавить("ДопУровень", Новый ОписаниеТипов("Число"));
	ТаблицаМодуля.Колонки.Добавить("СдвигатьВперед", Новый ОписаниеТипов("Булево"));
	ТаблицаМодуля.Колонки.Добавить("СдвигатьНазад", Новый ОписаниеТипов("Булево"));
	ТаблицаМодуля.Колонки.Добавить("ШагНазад", Новый ОписаниеТипов("Булево"));
	ТаблицаМодуля.Колонки.Добавить("СтрокаОткрыта", Новый ОписаниеТипов("Булево"));
	
	Возврат ТаблицаМодуля;
	
КонецФункции

Функция ПравилаОтступов()
	
	Правила = Новый Структура();
	Правила.Вставить("Метод", Новый Структура("ПустаяСтрокаДо, ПустаяСтрокаПосле", Истина, Истина));
	Правила.Вставить("Условие", Новый Структура("ПустаяСтрокаДо, ПустаяСтрокаПосле", Истина, Истина));
	Правила.Вставить("Цикл", Новый Структура("ПустаяСтрокаДо, ПустаяСтрокаПосле", Истина, Истина));
	Правила.Вставить("Попытка", Новый Структура("ПустаяСтрокаДо, ПустаяСтрокаПосле", Истина, Истина));
	Правила.Вставить("Возврат", Новый Структура("ПустаяСтрокаДо, ПустаяСтрокаПосле", Истина, Истина));
	
	Возврат Правила;
	
КонецФункции

Функция СледующаяСтрокаМодуля(ТаблицаМодуля, НомерТекущейСтроки)
	
	Если НомерТекущейСтроки >= ТаблицаМодуля.Количество() - 1 Тогда
		
		Возврат Неопределено;
		
	КонецЕсли;
	
	Возврат ТаблицаМодуля[НомерТекущейСтроки + 1];
	
КонецФункции

Процедура НоваяСтрокаМодуля(ТаблицаМодуля, Позиция, ТекстСтроки)
	
	НоваяСтрока = ТаблицаМодуля.Вставить(Позиция);
	НоваяСтрока.Текст = ТекстСтроки;
	
КонецПроцедуры

Функция ОтноситсяКБлоку(СтрокаМодуля, Блок)
	
	Для каждого НачалоСтроки Из Блок Цикл
		
		ТекстВыражения = "^" + НачалоСтроки + "(\b|\s+)";
		РегВыражение = Новый РегулярноеВыражение(ТекстВыражения);
		Совпадения = РегВыражение.НайтиСовпадения(СтрокаМодуля.Текст);
		
		Если Совпадения.Количество() > 0 Тогда
			
			Возврат Истина;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция НовыйТекстМодуля(ТаблицаМодуля)
	
	НовыйТекстМодуля = "";
	
	Для каждого СтрокаМодуля Из ТаблицаМодуля Цикл
		
		СтрокаСКомментарием = СтрокаМодуля.Текст;
		
		Если НЕ ПустаяСтрока(СтрокаМодуля.Комментарий) Тогда
		
			Если ПустаяСтрока(СтрокаСКомментарием) Тогда

				СтрокаСКомментарием = "// " + СтрокаМодуля.Комментарий;

			Иначе

				СтрокаСКомментарием = СтрокаСКомментарием + " // " + СтрокаМодуля.Комментарий;

			КонецЕсли;

		КонецЕсли;

		НоваяСтрокаМодуля = ДобавитьСдвиги(СтрокаСКомментарием, СтрокаМодуля.Уровень + СтрокаМодуля.ДопУровень) 
			+ Символы.ПС;
		
		НовыйТекстМодуля = НовыйТекстМодуля + НоваяСтрокаМодуля;
		
	КонецЦикла;
	
	Возврат НовыйТекстМодуля;
	
КонецФункции

Функция СтруктураСтрокиМодуля(СтрокаМодуля)
	
	СтрокаМодуля = СокрЛП(СтрокаМодуля);
	
	Если СтрНачинаетсяС(СтрокаМодуля, "//") Тогда
		СтрокаМодуляБезКомментария = "";
		СтрокаКомментария = СокрЛП(Сред(СтрокаМодуля, 3));
	Иначе
		
		ТекстВыражения = "(.*)\/\/(?=([^""]*""[^""]*"")*(?![^""]*""))(.*)";
		РегВыражение = Новый РегулярноеВыражение(ТекстВыражения);
		
		Совпадения = РегВыражение.НайтиСовпадения(СтрокаМодуля);
		
		Если Совпадения.Количество() > 0 Тогда
			
			Для Каждого Совпадение Из Совпадения Цикл
				
				СтрокаМодуляБезКомментария = Совпадение.Группы[1].Значение;
				СтрокаКомментария = Совпадение.Группы[3].Значение;
				
			КонецЦикла;
			
		Иначе
			
			СтрокаМодуляБезКомментария = СтрокаМодуля;
			СтрокаКомментария = "";
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если Прав(СтрокаМодуляБезКомментария, 1) = ";" Тогда
		
		СтрокаМодуляБезКомментария = СокрЛП(Сред(СтрокаМодуляБезКомментария, 0,
			СтрДлина(СтрокаМодуляБезКомментария) - 1)) + ";";
		
	КонецЕсли;
	
	Возврат Новый Структура("СтрокаМодуля, Комментарий", СтрокаМодуляБезКомментария, СтрокаКомментария);
	
КонецФункции

Процедура ДобавитьЛогВФайл(ИмяФайла, Данные)
	
	Текст = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.UTF8, , Истина);
	Текст.ЗаписатьСтроку("" + ТекущаяДата() + " " + Данные);
	Текст.Закрыть();
	
	ОсвободитьОбъект(Текст);
	
КонецПроцедуры

Функция ПривестиККаноническомуНаписанию(ТаблицаМодуля, ПараметрыФорматирования)

	Если НЕ ПараметрыФорматирования.ПриводитьККаноническомуНаписанию Тогда
		
		Возврат Ложь;

	КонецЕсли;

	Эталоны = ТекстИзФайлаМассивом("scripts/CodeFormatter/templates/etalons.txt");

	КлючевыеСлова = Новый ТаблицаЗначений;
	КлючевыеСлова.Колонки.Добавить("Наименование");
	
	Для Каждого Эталон Из Эталоны Цикл

		СтрокаТаблицы = КлючевыеСлова.Добавить();
		СтрокаТаблицы.Наименование = Эталон;

	КонецЦикла;
	
	КлючевыеСлова.Свернуть("Наименование");
	
	СтрокаОткрыта = Ложь;
	ОбластьОткрыта = Ложь;
	
	Для каждого СтрокаТабилцыМодуля Из ТаблицаМодуля Цикл
		
		ИсходнаяСтрокаМодуля = СтрокаТабилцыМодуля.Текст;
		
		Если ПустаяСтрока(ИсходнаяСтрокаМодуля) Тогда // Строка пустая
			Продолжить;
		КонецЕсли;

		Если Лев(ИсходнаяСтрокаМодуля, 1) = "|" Тогда
			Продолжить;
		КонецЕсли;
		
		ТекстВыражения = """[^""]*(?:""""[^""]*)*(""|$)";
		РегВыражение = Новый РегулярноеВыражение(ТекстВыражения);
		
		Совпадения = РегВыражение.НайтиСовпадения(ИсходнаяСтрокаМодуля);
		
		ЗаменыКавычек = Новый Соответствие();

		Если Совпадения.Количество() > 0 Тогда
			
			НомерКавычек = 0;
			Для Каждого Совпадение Из Совпадения Цикл
				
				НомерКавычек = НомерКавычек + 1;

				СтрокаВКавычках = Совпадение.Группы[0].Значение;

				КлючКавычек = "{{{НомерКавычек" + НомерКавычек + "}}}";
				ЗаменыКавычек.Вставить(КлючКавычек, СтрокаВКавычках);

				ИсходнаяСтрокаМодуля = СтрЗаменить(ИсходнаяСтрокаМодуля, СтрокаВКавычках, КлючКавычек);
				
			КонецЦикла;
			
		КонецЕсли;

		// Проверяем правильное использование каждого ключевого слова.
		ИзмененнаяСтрокаМодуля = ИсходнаяСтрокаМодуля;
		Для Каждого ЭлементТаблицы Из КлючевыеСлова Цикл

			Эталон = ЭлементТаблицы.Наименование;
			РегВыражение = Новый РегулярноеВыражение("\b" + Эталон + "\b");
			ИзмененнаяСтрокаМодуля = РегВыражение.Заменить(ИзмененнаяСтрокаМодуля, Эталон);
			
			ФайлИзменен = Истина;
			
		КонецЦикла;
		
		Для каждого КлючЗначениеКавычек Из ЗаменыКавычек Цикл

			ИзмененнаяСтрокаМодуля = СтрЗаменить(ИзмененнаяСтрокаМодуля, 
				КлючЗначениеКавычек.Ключ,
				КлючЗначениеКавычек.Значение);

		КонецЦикла;

		СтрокаТабилцыМодуля.Текст = ИзмененнаяСтрокаМодуля;

	КонецЦикла;
	
	Возврат ФайлИзменен;
	
КонецФункции

Функция ТекстИзФайлаМассивом(ИмяФайла)

	ФайлОбмена = Новый Файл(ИмяФайла);
	ТекстИзФайла = "";
	
	Если ФайлОбмена.Существует() Тогда

		Текст = Новый ЧтениеТекста(ИмяФайла, КодировкаТекста.UTF8);
		ТекстИзФайла = Текст.Прочитать();
		Текст.Закрыть();
		ОсвободитьОбъект(Текст);
		
	КонецЕсли;

	Возврат СтрРазделить(ТекстИзФайла, Символы.ПС);

КонецФункции

#КонецОбласти
