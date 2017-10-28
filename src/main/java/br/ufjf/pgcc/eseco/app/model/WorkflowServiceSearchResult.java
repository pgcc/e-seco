package br.ufjf.pgcc.eseco.app.model;

public class WorkflowServiceSearchResult {

    private String name;
    private String repositoryName;
    private String serviceIdRepository;
    private String componentType;
    private String shortDescription; //comments in prime
    private String description; //comments in prime
    private String createdAt;
    private String archivedAt; //publication data in prime
    private String updatedAt;
    private String owner; //scientist id from biocatalogue
    private String ownerName; //scientist name in prime
    private String ownerCity;
    private String ownerCountry;
    private String ownerCountryFlagImage;
    private String fileLocation; //address in prime
    private String licenseType; //license in prime
    private String monitoringStatusLabel;
    private String monitoringStatusLastChecked;

    //to servicesOnly
    private String inputs;
    private String outputs;
    private String serviceType;
    private String dependencies;

    //prime
    private String returnPrimeSin;
    private String returnPrimeSem;
    private String receptionPrimeSem;
    private String representationPrimeSem;
    private String functionalRequirementPrimeSem;
    private String nonFunctionalRequirementPrimePra;
    private String artifactPrimePra;
    private String domainPrimePra;
    private String purposePrimePra;
    private String providerPrimePra;
    private String restrictionPrimePra;
    private String hardwareCPUPrimePra;
    private String hardwareOperationalSystemPrimePra;
    private String hardwareRAMPrimePra;
    private String hardwareROMPrimePra;


    /* GETTERS/SETTERS */

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRepositoryName() {
        return repositoryName;
    }

    public void setRepositoryName(String repositoryName) {
        this.repositoryName = repositoryName;
    }

    public String getServiceIdRepository() {
        return serviceIdRepository;
    }

    public void setServiceIdRepository(String serviceIdRepository) {
        this.serviceIdRepository = serviceIdRepository;
    }

    public String getComponentType() {
        return componentType;
    }

    public void setComponentType(String componentType) {
        this.componentType = componentType;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getArchivedAt() {
        return archivedAt;
    }

    public void setArchivedAt(String archivedAt) {
        this.archivedAt = archivedAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getOwnerCity() {
        return ownerCity;
    }

    public void setOwnerCity(String ownerCity) {
        this.ownerCity = ownerCity;
    }

    public String getOwnerCountry() {
        return ownerCountry;
    }

    public void setOwnerCountry(String ownerCountry) {
        this.ownerCountry = ownerCountry;
    }

    public String getOwnerCountryFlagImage() {
        return ownerCountryFlagImage;
    }

    public void setOwnerCountryFlagImage(String ownerCountryFlagImage) {
        this.ownerCountryFlagImage = ownerCountryFlagImage;
    }

    public String getFileLocation() {
        return fileLocation;
    }

    public void setFileLocation(String fileLocation) {
        this.fileLocation = fileLocation;
    }

    public String getLicenseType() {
        return licenseType;
    }

    public void setLicenseType(String licenseType) {
        this.licenseType = licenseType;
    }

    public String getMonitoringStatusLabel() {
        return monitoringStatusLabel;
    }

    public void setMonitoringStatusLabel(String monitoringStatusLabel) {
        this.monitoringStatusLabel = monitoringStatusLabel;
    }

    public String getMonitoringStatusLastChecked() {
        return monitoringStatusLastChecked;
    }

    public void setMonitoringStatusLastChecked(String monitoringStatusLastChecked) {
        this.monitoringStatusLastChecked = monitoringStatusLastChecked;
    }

    public String getInputs() {
        return inputs;
    }

    public void setInputs(String inputs) {
        this.inputs = inputs;
    }

    public String getOutputs() {
        return outputs;
    }

    public void setOutputs(String outputs) {
        this.outputs = outputs;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getDependencies() {
        return dependencies;
    }

    public void setDependencies(String dependencies) {
        this.dependencies = dependencies;
    }

    public String getReturnPrimeSin() {
        return returnPrimeSin;
    }

    public void setReturnPrimeSin(String returnPrimeSin) {
        this.returnPrimeSin = returnPrimeSin;
    }

    public String getReturnPrimeSem() {
        return returnPrimeSem;
    }

    public void setReturnPrimeSem(String returnPrimeSem) {
        this.returnPrimeSem = returnPrimeSem;
    }

    public String getReceptionPrimeSem() {
        return receptionPrimeSem;
    }

    public void setReceptionPrimeSem(String receptionPrimeSem) {
        this.receptionPrimeSem = receptionPrimeSem;
    }

    public String getRepresentationPrimeSem() {
        return representationPrimeSem;
    }

    public void setRepresentationPrimeSem(String representationPrimeSem) {
        this.representationPrimeSem = representationPrimeSem;
    }

    public String getFunctionalRequirementPrimeSem() {
        return functionalRequirementPrimeSem;
    }

    public void setFunctionalRequirementPrimeSem(String functionalRequirementPrimeSem) {
        this.functionalRequirementPrimeSem = functionalRequirementPrimeSem;
    }

    public String getNonFunctionalRequirementPrimePra() {
        return nonFunctionalRequirementPrimePra;
    }

    public void setNonFunctionalRequirementPrimePra(String nonFunctionalRequirementPrimePra) {
        this.nonFunctionalRequirementPrimePra = nonFunctionalRequirementPrimePra;
    }

    public String getArtifactPrimePra() {
        return artifactPrimePra;
    }

    public void setArtifactPrimePra(String artifactPrimePra) {
        this.artifactPrimePra = artifactPrimePra;
    }

    public String getDomainPrimePra() {
        return domainPrimePra;
    }

    public void setDomainPrimePra(String domainPrimePra) {
        this.domainPrimePra = domainPrimePra;
    }

    public String getPurposePrimePra() {
        return purposePrimePra;
    }

    public void setPurposePrimePra(String purposePrimePra) {
        this.purposePrimePra = purposePrimePra;
    }

    public String getProviderPrimePra() {
        return providerPrimePra;
    }

    public void setProviderPrimePra(String providerPrimePra) {
        this.providerPrimePra = providerPrimePra;
    }

    public String getRestrictionPrimePra() {
        return restrictionPrimePra;
    }

    public void setRestrictionPrimePra(String restrictionPrimePra) {
        this.restrictionPrimePra = restrictionPrimePra;
    }

    public String getHardwareCPUPrimePra() {
        return hardwareCPUPrimePra;
    }

    public void setHardwareCPUPrimePra(String hardwareCPUPrimePra) {
        this.hardwareCPUPrimePra = hardwareCPUPrimePra;
    }

    public String getHardwareOperationalSystemPrimePra() {
        return hardwareOperationalSystemPrimePra;
    }

    public void setHardwareOperationalSystemPrimePra(String hardwareOperationalSystemPrimePra) {
        this.hardwareOperationalSystemPrimePra = hardwareOperationalSystemPrimePra;
    }

    public String getHardwareRAMPrimePra() {
        return hardwareRAMPrimePra;
    }

    public void setHardwareRAMPrimePra(String hardwareRAMPrimePra) {
        this.hardwareRAMPrimePra = hardwareRAMPrimePra;
    }

    public String getHardwareROMPrimePra() {
        return hardwareROMPrimePra;
    }

    public void setHardwareROMPrimePra(String hardwareROMPrimePra) {
        this.hardwareROMPrimePra = hardwareROMPrimePra;
    }
}
