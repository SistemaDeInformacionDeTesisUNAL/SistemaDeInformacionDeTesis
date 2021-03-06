class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :update, :destroy, :edit]
  before_action :set_contribution_id, only: [:users, :newUser, :tags, :sendTags]

  # GET /contributions
  # GET /contributions.json

  def index
  #  @contributions = Contribution.all
    #almacena todos los tags
    @tags = Tag.all.order("name ASC")
    #almacena todos los grupos
    @groups = InvestigationGroup.all.order("name ASC")
    #almacena todas las contribuciones por tags
    @contributions = Contribution.contributions
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
    @Students = Contribution.students(:id => params[:id])
    @Teachers = Contribution.teachers(:id => params[:id])
  end

  # GET /contributions/new
  def new
    @contribution_group = InvestigationGroup.find(params[:investigation_group_id])
    @contribution = Contribution.new
  end

  # GET /contributions/1/edit
  def edit
    @invGroup = InvestigationGroup.find(params[:investigation_group_id])
  end
  # POST /contributions
  # POST /contributions.json
  def create
    @contribution = Contribution.new(contribution_params)
    respond_to do |format|
      @contribution.state = 2
      if @contribution.save
         @Owner=InvestigationGroup.teacher_group_owner(:id => @contribution.investigation_group_id)
         @group=InvestigationGroup.find(@contribution.investigation_group_id)
         if student_signed_in?
           @user=current_student
         else
           @user=current_teacher
         end
         EventMailer.contributionCreated(:contribution=>@contribution,:user=>@user,:owner=>@Owner, :group => @group).deliver!
        format.html { redirect_to contributionsGroup_investigation_groups_path(@contribution.investigation_group_id), notice: 'Contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to contributionsGroup_investigation_groups_path(:id=>@contribution.investigation_group_id), notice: 'Contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def users
    @Students = Contribution.students(:id => params[:contribution_id])
    @Teachers = Contribution.teachers(:id => params[:contribution_id])
  end

  def newUser
    studentsContr = Contribution.students(:id => params[:contribution_id])
    students = InvestigationGroup.students_group(:id => params[:investigation_group_id])
    @Students=[]
    students.each do |stud|
      unless studentsContr.include? stud
        @Students.push(stud)
      end
    end
    teachersContr = Contribution.teachers(:id => params[:contribution_id])
    teachers = TeacherInvestigationGroup.load_teachers(:ids => params[:investigation_group_id])
    @Teachers=[]
    teachers.each do |teach|
      tea = Teacher.find( teach.teacher.id )
      unless teachersContr.include? tea
        @Teachers.push(teach)
      end
    end
  end

  def createUser
    @user_contribution = UserContribution.new
    @user_contribution.contribution_id = params[:contr]
    @user_contribution.userable_type = params[:type]
    @user_contribution.userable_id = params[:ids]
    if @user_contribution.save
      redirect_to investigation_group_contribution_users_path, notice: 'Contribution was successfully updated.'
    else
      render :root
    end
  end

  def deleteUser
    @user_contribution = Contribution.user_contribution( :type=>params[:type], :ids=>params[:ids], :contr=>params[:contr] )
    @user_contribution.each do |us|
      us.destroy
    end
    redirect_to investigation_group_contribution_users_path, notice: 'Contribution was successfully destroyed.'
  end

  def tags
    tags = Tag.tags_contribution(:contr=>@contribution.id)
    @myTags=''
    tags.each do |tag|
      @myTags<<tag.name
      if tag != tags.last
        @myTags<<', '
      end
    end
  end

  def sendTags
    cadena = params[:tags]
    arrayTags = cadena.split(', ')
    puts arrayTags
    arrayTags.each do |tag|
      if Tag.find_by(name: tag) == nil
        Tag.create!( name: tag )
      end
      tagId = Tag.find_by(name: tag)
      if Tag.load_tags_contribution(:ids=>tagId.id,:contr=>@contribution.id) == []
        TagContribution.create!( tag_id: tagId.id, contribution_id: @contribution.id )
      end
      if Tag.load_tags_invGroup(:ids=>tagId.id,:inv=>params[:investigation_group_id]) == []
        TagInvestigationGroup.create!( tag_id: tagId.id, investigation_group_id: params[:investigation_group_id] )
      end
    end
    tags = Tag.tag_in_contribution(:contr=>@contribution.id)
    tags.each do |tagContribution|
      tag = Tag.find(tagContribution.tag_id)
      unless arrayTags.include? tag.name
        puts tagContribution
        tagContribution.destroy
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    def set_contribution_id
      @contribution = Contribution.find(params[:contribution_id])
      @invGroup = InvestigationGroup.find(params[:investigation_group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_params
      params.require(:contribution).permit(:name, :publication_date, :description, :investigation_group_id, :file, :ids, :type, :contr, :tags)
    end
end
