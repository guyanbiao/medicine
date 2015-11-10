class HomeController < ApplicationController
  def index
  end

  def import
    s = Roo::Excelx.new(params[:excel][:content].path).sheet(0)
    prescription = {}
    unset prescription
    s.each_with_index do |row, index|
      if row.all? {|cell| cell.blank?}
        new_round(prescription)
      elsif new_start?(row)
        new_round(prescription)
        prescription[:name] = row[0]
      elsif medicine?(row)
        prescription[:medicines].push({name: row[0], count: row[1]})
      elsif prescription_amount?(row)
        prescription[:amount] =  row[1].match /\d+/
      elsif index == s.count - 1
        new_round(prescription)
      end
    end
    render text: "导入成功"
  end

  def patients
    @patients = Patient.all
  end

  def medicines
    @medicines = Medicine.all
  end

  private
  def new_round(p)
    if p[:medicines].length > 0
      record p
      unset p
    end
  end

  def record(prescript)
    m = prescript[:name].split(" ").reject {|x| x == "强直"}
    p = Patient.where(name: m[0],age: age(m[2]), gender: gender(m[1])).first_or_initialize
    p.symptoms.build name: m[3]

    prescription = p.prescriptions.build(amount: prescript[:amount])

    prescript[:medicines].each do |m|
      prescription.prescription_items.build(amount: m[:count],
        medicine: Medicine.where(name: m[:name]).first_or_create)
    end
    p.save

  end

  def age(x)
    x.match(/\d+/).to_s
  end

  def gender(x)
    x == "男" ? "male" : "female"
  end

  def unset(p)
    p[:medicines] = []
    p[:name] = ""
    p[:amount] = 0
  end

  def new_start?(row)
    row[0] and row[0].split(" ").length >= 4
  end

  def medicine?(row)
    (row[0] and row[0].length > 0) and
    (row[1].is_a?(Float) or row[1].is_a?(Integer))
  end
  def prescription_amount?(row)
    row[0] == nil and (row[1] =~ /^\d+$/)
  end
end
